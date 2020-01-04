import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddSubjectFormBloc extends FormBloc<String, String> {
  SubjectsRepository subjects;
  static List<String> _subjectNames = [];

  AddSubjectFormBloc() : super(isLoading: true) {
    subjects = getIt<SubjectsRepository>();
  }

  // ignore: close_sinks
  final nameField = TextFieldBloc(
    validators: [
      FieldBlocValidators.requiredTextFieldBloc,
      validateSubjectName,
      (val) => Validators.maxLength(val, 50),
    ],
  );

  // ignore: close_sinks
  final roomField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 35),
  ]);

  // ignore: close_sinks
  final buildingField = TextFieldBloc(validators: [
    (val) => Validators.maxLength(val, 35),
  ]);

  // ignore: close_sinks
  final teacherField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 40),
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
    yield* _getSubjectNames();
    yield* _getAvailableColors();
  }

  @override
  Stream<FormBlocState<String, String>> onReload() async* {
    yield* _getSubjectNames();
    yield* _getAvailableColors();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    int nextID = subjects.newID;
    // trimmed subject name
    String subjectName = nameField.value.trim();
    // get room field text
    String roomText = roomField.value.trim();
    // get building field text
    String building = buildingField.value.trim();
    // get teacher field text
    String teacher = teacherField.value.trim();
    // get the color value
    Color color = colorField.value;
    // create new subject based on text from form
    Subject newSubject = Subject(
      nextID,
      subjectName,
      roomText,
      building,
      teacher,
      color,
      null, // TODO: remove eventually
      false, // isDeleted value
    );
    subjects.addSubject(newSubject);
    yield state.toSuccess();
  }

  Stream<FormBlocState<String, String>> _getSubjectNames() async* {
    List<Subject> allSubjects = subjects.getAllSubjects();
    _subjectNames =
        allSubjects.map((subject) => subject.name.toLowerCase()).toList();
  }

  Stream<FormBlocState<String, String>> _getAvailableColors() async* {
    List<Color> subjectColors =
        subjects.getAllSubjects().map((subject) => subject.color).toList();
    availableColors = _allAvailableColors
        .where((color) => !subjectColors.contains(color))
        .toList();
    colorField.updateValue(availableColors.first);
    currentColor = availableColors.first;
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
    showOnPopDialog(context);
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
