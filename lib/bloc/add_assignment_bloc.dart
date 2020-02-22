import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentFormBloc extends FormBloc<String, String> with Popper {
  AddAssignmentFormBloc() : super(isLoading: true) {
    _assignments = sl<AssignmentsRepository>();
    _subjects = sl<SubjectsRepository>();
    addFieldBloc(fieldBloc: nameField);
    addFieldBloc(fieldBloc: dueDateField);
    addFieldBloc(fieldBloc: subjectField);
    addFieldBloc(fieldBloc: detailsField);
  }

  AssignmentsRepository _assignments;
  SubjectsRepository _subjects;
  static List<String> _assignmentNames = <String>[];

  final TextFieldBloc nameField = TextFieldBloc(
    name: 'assignment-name',
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateAssignmentName,
      (val) => Validators.maxLength(val, 50),
    ],
    initialValue: '',
  );

  final InputFieldBloc<DateTime> dueDateField = InputFieldBloc<DateTime>(
    name: 'assignment-due_date',
    validators: <String Function(DateTime)>[
      (date) {
        final dateString = date.toString();
        Validators.maxLength(dateString, 15);
        if (date == null || dateString.isEmpty) {
          return 'A due date is required!';
        }
        if (date.isBefore(DateTime.now().onlyDate)) {
          return 'Can\'t be before today!';
        }
        return null;
      },
    ],
    initialValue: DateTime.now(),
  );

  final SelectFieldBloc<Map<String, dynamic>> subjectField =
      SelectFieldBloc<Map<String, dynamic>>(
    name: 'assignment-subject',
    validators: <String Function(dynamic)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );

  final TextFieldBloc detailsField = TextFieldBloc(
    name: 'assignment-details',
    initialValue: '',
  );

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    _getAssignmentNames();
    _setSubjectFieldValues();
    yield state.toLoaded();
  }

  void _getAssignmentNames() {
    final allAssignments = _assignments.assignments;
    _assignmentNames = allAssignments
        .map((assignment) => assignment.name.toLowerCase())
        .toList();
  }

  void _setSubjectFieldValues() {
    final allSubjects = _subjects.subjects;
    for (final subject in allSubjects) {
      subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    final nextID = _assignments.nextID;
    // trimmed assignment name
    final assignmentName = nameField.value.trim();
    // trimmed due date
    final dueDate = dueDateField.value.onlyDate;
    // subject field value
    final subjectID = subjectField.value['value'] as int;
    final color = _subjects.getSubject(subjectID).color;
    // trimmed details text
    final detailsText = detailsField.value.trim();
    // create new assignment based on text from form
    final newAssignment = Assignment(
      nextID,
      assignmentName,
      dueDate,
      subjectID,
      detailsText,
      color,
    );
    await _assignments.addAssignment(newAssignment);
    yield state.toSuccess();
  }

  static String validateAssignmentName(String name) {
    if (_assignmentNames.contains(name.toLowerCase())) {
      return 'That assignment already exists';
    }
    return null;
  }

  @override
  bool fieldsAreEmpty() {
    // get all controllers' text and trim them
    final _nameField = nameField.value.trim();
    final _subjectField = subjectField.value;
    final _detailsField = detailsField.value.trim();
    // if they're all empty, return true
    if (_nameField.isEmpty && _subjectField == null && _detailsField.isEmpty) {
      return true;
    }
    // otherwise, return false
    return false;
  }
}
