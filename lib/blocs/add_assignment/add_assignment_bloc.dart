import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/ui/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/util/models/assignment.dart';
import 'package:school_life/util/models/subject.dart';

class AddAssignmentFormBloc extends FormBloc<String, dynamic> {
  final nameField = TextFieldBloc(
      validators: [FieldBlocValidators.requiredTextFieldBloc],
      initialValue: "");
  final dueDateField = InputFieldBloc(
      validators: [FieldBlocValidators.requiredInputFieldBloc],
      initialValue: DateTime.now());
  final subjectField = SelectFieldBloc(
    validators: [FieldBlocValidators.requiredSelectFieldBloc],
  );
  final detailsField = TextFieldBloc(initialValue: "");

  @override
  List<FieldBloc> get fieldBlocs =>
      [nameField, dueDateField, subjectField, detailsField];

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    print("submitting");
    // get the number of subjects, returns # of subjects + 1
    int _nextID = await RepositoryServiceAssignment.assignmentsCount();
    // trimmed assignment name
    String _assignmentName = nameField.value.trim();
    // trimmed due date
    DateTime _dueDate = dueDateField.value;
    DateTime _newDate = DateTime(_dueDate.year, _dueDate.month, _dueDate.day);
    // subject field value
    String _subjectName = subjectField.value;
    Subject _subject =
        await RepositoryServiceSubject.getSubjectFromName(_subjectName);
    int _subjectID = _subject.id;
    // trimmed details text
    String _detailsText = detailsField.value.trim();
    // create new assignment based on text from form
    Assignment newAssignment = Assignment(
      _nextID,
      _assignmentName,
      _newDate,
      _subjectID,
      _detailsText,
      false, // isDeleted value, always false when creating
    );
    await RepositoryServiceAssignment.addAssignment(newAssignment);
    yield state.toSuccess();
  }

  AddAssignmentFormBloc() {
    _setSubjectFieldValues();
  }

  void _setSubjectFieldValues() async {
    List<Subject> subjects = await RepositoryServiceSubject.getAllSubjects();
    for (int i = 0; i < subjects.length; i++) {
      subjectField.addItem(subjects[i].name);
    }
    _updateSubjectDropdown(subjects);
  }

  void _updateSubjectDropdown(List<Subject> subjects) {
    subjectField.updateInitialValue(subjects.first.name);
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String _nameField = nameField.value.trim();
    var _subjectField = subjectField.value;
    String _detailsField = detailsField.value.trim();
    // if they're all empty, return true
    if (_nameField.isEmpty && _subjectField != null && _detailsField.isEmpty)
      return true;
    // otherwise, return false
    return false;
  }

  Future<bool> requestPop(BuildContext context) async {
    // if the text fields are empty, user can exit
    if (_fieldsAreEmpty()) return true;
    // otherwise, show a popup dialog
    DialogOnPop.showPopupDialog(context);
    // default, return false
    return false;
  }
}
