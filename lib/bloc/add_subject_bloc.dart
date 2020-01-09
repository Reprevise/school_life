import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddSubjectFormBloc extends FormBloc<String, String> {
  AddSubjectFormBloc() : super(isLoading: true) {
    subjects = getIt<SubjectsRepository>();
  }

  SubjectsRepository subjects;
  static List<String> _subjectNames = <String>[];

  final TextFieldBloc nameField = TextFieldBloc(
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateSubjectName,
      (String val) => Validators.maxLength(val, 50),
    ],
  );

  final TextFieldBloc roomField =
      TextFieldBloc(validators: <String Function(String)>[
    FieldBlocValidators.requiredTextFieldBloc,
    (String val) => Validators.maxLength(val, 35),
  ]);

  final TextFieldBloc buildingField =
      TextFieldBloc(validators: <String Function(String)>[
    (String val) => Validators.maxLength(val, 35),
  ]);

  final TextFieldBloc teacherField =
      TextFieldBloc(validators: <String Function(String)>[
    FieldBlocValidators.requiredTextFieldBloc,
    (String val) => Validators.maxLength(val, 40),
  ]);

  final InputFieldBloc<Color> colorField = InputFieldBloc<Color>();

  final List<Color> _allAvailableColors = <Color>[
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
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        nameField,
        roomField,
        buildingField,
        teacherField,
        colorField
      ];

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
    final int nextID = subjects.newID;
    // trimmed subject name
    final String subjectName = nameField.value.trim();
    // get room field text
    final String roomText = roomField.value.trim();
    // get building field text
    final String building = buildingField.value.trim();
    // get teacher field text
    final String teacher = teacherField.value.trim();
    // get the color value
    final Color color = colorField.value;
    // create new subject based on text from form
    final Subject newSubject = Subject(
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
    final List<Subject> allSubjects = subjects.getAllSubjects();
    _subjectNames = allSubjects
        .map((Subject subject) => subject.name.toLowerCase())
        .toList();
  }

  Stream<FormBlocState<String, String>> _getAvailableColors() async* {
    final List<Color> subjectColors = subjects
        .getAllSubjects()
        .map((Subject subject) => subject.color)
        .toList();
    availableColors = _allAvailableColors
        .where((Color color) => !subjectColors.contains(color))
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
    if (_fieldsAreEmpty()) {
      return true;
    }
    showOnPopDialog(context);
    return false;
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    final String name = nameField.value.trim();
    final String room = roomField.value.trim();
    final String building = buildingField.value.trim();
    final String teacher = teacherField.value.trim();
    final Color subjectColor = colorField.value;
    // if they're all empty, return true
    if (name.isEmpty &&
        room.isEmpty &&
        building.isEmpty &&
        teacher.isEmpty &&
        subjectColor != null) {
      return true;
    }
    // otherwise, return false
    return false;
  }
}
