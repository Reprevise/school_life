import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/blocs/validators.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentFormBloc extends FormBloc<String, dynamic> {
  AssignmentsRepository assignments;
  SubjectsRepository subjects;
  static List<String> _assignmentNames = [];

  AddAssignmentFormBloc() : super(isLoading: true) {
    assignments = getIt<AssignmentsRepository>();
    subjects = getIt<SubjectsRepository>();
  }

  // ignore: close_sinks
  final nameField = TextFieldBloc(
    validators: [
      FieldBlocValidators.requiredTextFieldBloc,
      validateAssignmentName,
      (val) => Validators.maxLength(val, 50),
    ],
    initialValue: "",
  );
  // ignore: close_sinks
  final dueDateField = InputFieldBloc<DateTime>(
    validators: [
      (date) {
        String dateString = date.toString();
        Validators.maxLength(dateString, 15);
        if (date == null || dateString.isEmpty)
          return "A due date is required!";
        if (date.isBefore(DateTime.now().todaysDate)) {
          return "Can't be before today!";
        }
        return null;
      },
    ],
    initialValue: DateTime.now(),
  );
  // ignore: close_sinks
  final subjectField = SelectFieldBloc(
    validators: [FieldBlocValidators.requiredSelectFieldBloc],
  );
  // ignore: close_sinks
  final detailsField = TextFieldBloc(initialValue: "");

  @override
  List<FieldBloc> get fieldBlocs =>
      [nameField, dueDateField, subjectField, detailsField];

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
    int _nextID = assignments.newID;
    // trimmed assignment name
    String _assignmentName = nameField.value.trim();
    // trimmed due date
    DateTime _dueDate = dueDateField.value;
    DateTime _newDate = DateTime(_dueDate.year, _dueDate.month, _dueDate.day);
    // subject field value
    int _subjectID = subjectField.value['value'];
    Color color = subjects.getSubject(_subjectID).color;
    // trimmed details text
    String _detailsText = detailsField.value.trim();
    // create new assignment based on text from form
    Assignment newAssignment = Assignment(
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
    List<Assignment> allAssignments = assignments.getAllAssignments();
    _assignmentNames =
        allAssignments.map((assignment) => assignment.name.toLowerCase()).toList();
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    List<Subject> allSubjects = subjects.getAllSubjects();
    for (Subject subject in allSubjects) {
      subjectField.addItem({'name': subject.name, 'value': subject.id});
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
    String _nameField = nameField.value.trim();
    var _subjectField = subjectField.value;
    String _detailsField = detailsField.value.trim();
    // if they're all empty, return true
    if (_nameField.isEmpty && _subjectField == null && _detailsField.isEmpty)
      return true;
    // otherwise, return false
    return false;
  }

  Future<bool> requestPop(BuildContext context) async {
    // if the text fields are empty, user can exit
    if (_fieldsAreEmpty()) return true;
    // otherwise, show a popup dialog
    showOnPopDialog(context);
    // default, return false
    return false;
  }
}
