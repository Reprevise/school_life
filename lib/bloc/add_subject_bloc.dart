import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddSubjectFormBloc extends FormBloc<String, String> with Popper {
  AddSubjectFormBloc() : super(isLoading: true) {
    subjects = sl<SubjectsRepository>();
  }

  Subject subject;

  SubjectsRepository subjects;
  static List<String> _subjectNames = <String>[];

  final TextFieldBloc nameField = TextFieldBloc(
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateSubjectName,
      (val) => Validators.maxLength(val, 50),
    ],
  );

  final TextFieldBloc roomField =
      TextFieldBloc(validators: <String Function(String)>[
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 35),
  ]);

  final TextFieldBloc buildingField =
      TextFieldBloc(validators: <String Function(String)>[
    (val) => Validators.maxLength(val, 35),
  ]);

  final TextFieldBloc teacherField =
      TextFieldBloc(validators: <String Function(String)>[
    FieldBlocValidators.requiredTextFieldBloc,
    (val) => Validators.maxLength(val, 40),
  ]);

  final InputFieldBloc<Color> colorField = InputFieldBloc<Color>(
    validators: <String Function(Color)>[
      FieldBlocValidators.requiredInputFieldBloc,
    ],
  );

  // TODO: make a validator to ensure the same color isn't chosen
  List<Color> _takenColors;

  @override
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        nameField,
        roomField,
        buildingField,
        teacherField,
        colorField,
      ];

  void changeColor(Color newColor) {
    colorField.updateValue(newColor);
  }

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    _getSubjectNames();
    _getTakenColors();
    yield state.toLoaded();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // get the number of subjects, returns # of subjects + 1
    final nextID = subjects.nextID;
    // trimmed subject name
    final subjectName = nameField.value.trim();
    // get room field text
    final roomText = roomField.value.trim();
    // get building field text
    final building = buildingField.value.trim();
    // get teacher field text
    final teacher = teacherField.value.trim();
    // create new subject based on text from form
    subject = Subject(
      nextID,
      subjectName,
      roomText,
      building,
      teacher,
      colorField.value,
      null, // initial schedule
    );
    subjects.addSubject(subject);
    yield state.toSuccess();
  }

  void _getSubjectNames() {
    final allSubjects = subjects.subjects;
    _subjectNames =
        allSubjects.map((subject) => subject.name.toLowerCase()).toList();
  }

  void _getTakenColors() {
    final subjectColors =
        subjects.subjects.map((subject) => subject.color).toList();
    _takenColors = subjectColors;
  }

  static String validateSubjectName(String name) {
    if (_subjectNames.contains(name.toLowerCase())) {
      return 'That subject already exists';
    }
    return null;
  }

  @override
  bool fieldsAreEmpty() {
    // get all controllers' text and trim them
    final name = nameField.value.trim();
    final room = roomField.value.trim();
    final building = buildingField.value.trim();
    final teacher = teacherField.value.trim();
    final color = colorField.value;
    // if they're all empty, return true
    if (name.isEmpty &&
        room.isEmpty &&
        building.isEmpty &&
        teacher.isEmpty &&
        color == null) {
      return true;
    }
    // otherwise, return false
    return false;
  }
}
