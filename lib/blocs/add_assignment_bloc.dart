import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/blocs/validators.dart';
import 'package:school_life/screens/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';

class AddAssignmentFormBloc extends FormBloc<String, dynamic> {
  Map<int, Subject> subjectsFromIDs = <int, Subject>{};

  AddAssignmentFormBloc() : super(isLoading: true);

  // ignore: close_sinks
  final nameField = TextFieldBloc(
    validators: [
      FieldBlocValidators.requiredTextFieldBloc,
      (val) => Validators.maxLength(val, 22),
    ],
    initialValue: "",
  );
  // ignore: close_sinks
  final dueDateField = InputFieldBloc<DateTime>(
    validators: [
      FieldBlocValidators.requiredInputFieldBloc,
      (date) {
        Validators.maxLength(date.toString(), 15);
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
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    int _nextID = await AssignmentsRepository.assignmentsCount();
    // trimmed assignment name
    String _assignmentName = nameField.value.trim();
    // trimmed due date
    DateTime _dueDate = dueDateField.value;
    DateTime _newDate = DateTime(_dueDate.year, _dueDate.month, _dueDate.day);
    // subject field value
    print(subjectField.value);
    var _selectedSubject = subjectField.value;
    int _subjectID = _selectedSubject[1];
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
    AssignmentsRepository.addAssignment(newAssignment);
    yield state.toSuccess();
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    for (int i = 0; i < subjects.length; i++) {
      subjectField.addItem([subjects[i].name, subjects[i].id]);
    }
    subjectField.updateInitialValue(subjects.first.name);
    yield state.toLoaded();
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
