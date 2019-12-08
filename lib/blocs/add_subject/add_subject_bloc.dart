import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/ui/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/subject.dart';

class AddSubjectFormBloc extends FormBloc<String, String> {
  final nameField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) {
      if (val.length > 22) return 'Shorten to 22 characters please';
      return null;
    }
  ]);
  final roomField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) {
      if (val.length > 15) return 'Shorten to 15 characters please';
      return null;
    }
  ]);
  final buildingField = TextFieldBloc(validators: [
    (val) {
      if (val.length > 20) return 'Shorten to 20 characters please';
      return null;
    }
  ]);
  final teacherField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) {
      if (val.length > 30) return 'Shorten to 30 characters please';
      return null;
    }
  ]);
  final colorField = InputFieldBloc<Color>();

  final List<Color> _allAvailableColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  List<Color> availableColors;
  Color currentColor = Colors.yellow;

  AddSubjectFormBloc() {
    nameField.addAsyncValidators([_subjectNameValid]);
    _getAvailableColors();
  }

  _getAvailableColors() async {
    availableColors =
        await RepositoryServiceSubject.getAvailableColors(_allAvailableColors);
    colorField.updateValue(availableColors.first);
    currentColor = Color(availableColors.first.value);
  }

  @override
  List<FieldBloc> get fieldBlocs =>
      [nameField, roomField, buildingField, teacherField];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    int nextID = await RepositoryServiceSubject.subjectsCount();
    // trimmed subject name
    String subjectName = nameField.value.trim();
    // get room field text
    String roomText = roomField.value.trim();
    // get building field text
    String building = buildingField.value.trim();
    // get teacher field text
    String teacher = teacherField.value.trim();
    // get the color value
    int colorValue = colorField.value.value;
    // create new subject based on text from form
    Subject newSubject = Subject(
      nextID,
      subjectName,
      roomText,
      building,
      teacher,
      colorValue,
      false, // isDeleted value
    );
    await RepositoryServiceSubject.addSubject(newSubject);
    yield state.toSuccess();
  }

  Future<String> _subjectNameValid(String name) async {
    if (await RepositoryServiceSubject.checkIfSubNameExists(name.toLowerCase()))
      return 'That subject already exists';
    return null;
  }

  //! needs to return a future because WillPopScope needs it to be
  Future<bool> canPop(BuildContext context) async {
    if (_fieldsAreEmpty()) return true;
    DialogOnPop.showPopupDialog(context);
    return false;
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String name = nameField.value.trim();
    String room = roomField.value.trim();
    String building = buildingField.value.trim();
    String teacher = teacherField.value.trim();
    var subjectColor = colorField.value;
    // if they're all empty, return true
    if (name.isEmpty &&
        room.isEmpty &&
        building.isEmpty &&
        teacher.isEmpty &&
        subjectColor != null) return true;
    // otherwise, return false
    return false;
  }
}
