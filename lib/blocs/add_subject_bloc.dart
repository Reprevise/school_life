import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/blocs/validators.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddSubjectFormBloc extends FormBloc<String, String> {
  static List<String> _subjectNames = [];

  AddSubjectFormBloc() : super(isLoading: true);

  // ignore: close_sinks
  final nameField = TextFieldBloc(
    validators: [
      FieldBlocValidators.requiredTextFieldBloc,
      validateSubjectName,
      (val) => Validators.maxLength(val, 22),
    ],
  );

  // ignore: close_sinks
  final roomField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 15),
  ]);

  // ignore: close_sinks
  final buildingField = TextFieldBloc(validators: [
    (val) => Validators.maxLength(val, 20),
  ]);

  // ignore: close_sinks
  final teacherField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 30),
  ]);

  // ignore: close_sinks
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

  @override
  List<FieldBloc> get fieldBlocs =>
      [nameField, roomField, buildingField, teacherField, colorField];

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    await _getSubjectNames();
    yield* _getAvailableColors();
  }

  @override
  Stream<FormBlocState<String, String>> onReload() async* {
    await _getSubjectNames();
    yield* _getAvailableColors();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    int nextID = await SubjectsRepository.getNewSubjectID();
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
    SubjectsRepository.addSubject(newSubject);
    yield state.toSuccess();
  }

  Future<void> _getSubjectNames() async {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    _subjectNames =
        subjects.map((subject) => subject.name.toLowerCase()).toList();
  }

  Stream<FormBlocState<String, String>> _getAvailableColors() async* {
    final availableColors =
        await SubjectsRepository.getAvailableColors(_allAvailableColors);
    colorField.updateValue(availableColors.first);
    currentColor = Color(availableColors.first.value);
    yield state.toLoaded();
  }

  static String validateSubjectName(String name) {
    if (_subjectNames.contains(name.toLowerCase()))
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
