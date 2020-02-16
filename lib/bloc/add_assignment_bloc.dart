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
    assignments = sl<AssignmentsRepository>();
    subjects = sl<SubjectsRepository>();
  }

  AssignmentsRepository assignments;
  SubjectsRepository subjects;
  static List<String> _assignmentNames = <String>[];

  final TextFieldBloc nameField = TextFieldBloc(
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateAssignmentName,
      (val) => Validators.maxLength(val, 50),
    ],
    initialValue: '',
  );

  final InputFieldBloc<DateTime> dueDateField = InputFieldBloc<DateTime>(
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
    validators: <String Function(dynamic)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );

  final TextFieldBloc detailsField = TextFieldBloc(initialValue: '');

  @override
  List<FieldBloc> get fieldBlocs =>
      <FieldBloc>[nameField, dueDateField, subjectField, detailsField];

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    _getAssignmentNames();
    _setSubjectFieldValues();
    yield state.toLoaded();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    final nextID = assignments.nextID;
    // trimmed assignment name
    final assignmentName = nameField.value.trim();
    // trimmed due date
    final dueDate = dueDateField.value.onlyDate;
    // subject field value
    final subjectID = subjectField.value['value'] as int;
    final color = subjects.getSubject(subjectID).color;
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
    await assignments.addAssignment(newAssignment);
    yield state.toSuccess();
  }

  void _getAssignmentNames() {
    final allAssignments = assignments.assignments;
    _assignmentNames = allAssignments
        .map((assignment) => assignment.name.toLowerCase())
        .toList();
  }

  void _setSubjectFieldValues() {
    final allSubjects = subjects.subjects;
    for (final subject in allSubjects) {
      subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
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
