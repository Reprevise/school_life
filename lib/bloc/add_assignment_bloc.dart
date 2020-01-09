import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentFormBloc extends FormBloc<String, dynamic> {
  AddAssignmentFormBloc() : super(isLoading: true) {
    assignments = getIt<AssignmentsRepository>();
    subjects = getIt<SubjectsRepository>();
  }

  AssignmentsRepository assignments;
  SubjectsRepository subjects;
  static List<String> _assignmentNames = <String>[];

  // ignore: close_sinks
  final TextFieldBloc nameField = TextFieldBloc(
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateAssignmentName,
      (String val) => Validators.maxLength(val, 50),
    ],
    initialValue: '',
  );

  // ignore: close_sinks
  final InputFieldBloc<DateTime> dueDateField = InputFieldBloc<DateTime>(
    validators: <String Function(DateTime)>[
      (DateTime date) {
        final String dateString = date.toString();
        Validators.maxLength(dateString, 15);
        if (date == null || dateString.isEmpty)
          return 'A due date is required!';
        if (date.isBefore(DateTime.now().todaysDate)) {
          return 'Can\'t be before today!';
        }
        return null;
      },
    ],
    initialValue: DateTime.now(),
  );

  // ignore: close_sinks
  final SelectFieldBloc<Map<String, String>> subjectField =
      SelectFieldBloc<Map<String, String>>(
    validators: <String Function(dynamic)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );

  // ignore: close_sinks
  final TextFieldBloc detailsField = TextFieldBloc(initialValue: '');

  @override
  List<FieldBloc> get fieldBlocs =>
      <FieldBloc>[nameField, dueDateField, subjectField, detailsField];

  @override
  Stream<FormBlocState<String, dynamic>> onLoading() async* {
    await _getAssignmentNames();
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
    await _getAssignmentNames();
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    final int _nextID = assignments.newID;
    // trimmed assignment name
    final String _assignmentName = nameField.value.trim();
    // trimmed due date
    final DateTime _dueDate = dueDateField.value;
    final DateTime _newDate =
        DateTime(_dueDate.year, _dueDate.month, _dueDate.day);
    // subject field value
    final String _subjectIDString = subjectField.value['value'];
    final int _subjectID = int.parse(_subjectIDString);
    final Color color = subjects.getSubject(_subjectID).color;
    // trimmed details text
    final String _detailsText = detailsField.value.trim();
    // create new assignment based on text from form
    final Assignment newAssignment = Assignment(
      _nextID,
      _assignmentName,
      _newDate,
      _subjectID,
      _detailsText,
      color,
      false, // isDeleted value, always false when creating
    );
    assignments.addAssignment(newAssignment);
    yield state.toSuccess();
  }

  Future<void> _getAssignmentNames() async {
    final List<Assignment> allAssignments = assignments.getAllAssignments();
    _assignmentNames = allAssignments
        .map((Assignment assignment) => assignment.name.toLowerCase())
        .toList();
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    final List<Subject> allSubjects = subjects.getAllSubjects();
    for (Subject subject in allSubjects) {
      subjectField.addItem(<String, String>{
        'name': subject.name,
        'value': subject.id.toString()
      });
    }
    yield state.toLoaded();
  }

  static String validateAssignmentName(String name) {
    if (_assignmentNames.contains(name.toLowerCase()))
      return 'That assignment already exists';
    return null;
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    final String _nameField = nameField.value.trim();
    final Map<String, String> _subjectField = subjectField.value;
    final String _detailsField = detailsField.value.trim();
    // if they're all empty, return true
    if (_nameField.isEmpty && _subjectField == null && _detailsField.isEmpty)
      return true;
    // otherwise, return false
    return false;
  }

  Future<bool> requestPop(BuildContext context) async {
    // if the text fields are empty, user can exit
    if (_fieldsAreEmpty()) {
      return true;
    }
    // otherwise, show a popup dialog
    showOnPopDialog(context);
    // default, return false
    return false;
  }
}
