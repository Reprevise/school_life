import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddSubjectFormBloc extends FormBloc<String, String> with Popper {
  AddSubjectFormBloc() : super(isLoading: true) {
    subjectsRepo = sl<SubjectsRepository>();
    addFieldBlocs(fieldBlocs: [
      nameField,
      roomField,
      buildingField,
      teacherField,
      colorField,
    ]);
  }

  Subject _subject;
  Subject get subject => _subject;

  SubjectsRepository subjectsRepo;

  static List<String> _subjectNames;

  static List<Color> _takenColors;

  final nameField = TextFieldBloc(
    name: 'subject-name',
    validators: [
      FieldBlocValidators.required,
      validateSubjectName,
      (val) => Validators.maxLength(val, 50),
    ],
  );

  final roomField = TextFieldBloc(
    name: 'subject-room',
    validators: [
      FieldBlocValidators.required,
      (val) => Validators.maxLength(val, 35),
    ],
  );

  final buildingField = TextFieldBloc(
    name: 'subject-building',
    validators: [
      (val) => Validators.maxLength(val, 35),
    ],
  );

  final teacherField = TextFieldBloc(
    name: 'subject-teacher',
    validators: [
      FieldBlocValidators.required,
      (val) => Validators.maxLength(val, 40),
    ],
  );

  final colorField = InputFieldBloc<Color, Object>(
    name: 'subject-color',
    validators: [
      FieldBlocValidators.required,
      validateColor,
    ],
  );

  void changeColor(Color newColor) {
    colorField.updateValue(newColor);
  }

  @override
  void onLoading() {
    _updateSubjectNames();
    _updateTakenColors();
    emitLoaded();
  }

  @override
  void onSubmitting() {
    // get the number of subjects, returns # of subjects + 1
    final nextID = subjectsRepo.nextID;
    // trimmed subject name
    final subjectName = nameField.value.trim();
    // get room field text
    final roomText = roomField.value.trim();
    // get building field text
    final building = buildingField.value.trim();
    // get teacher field text
    final teacher = teacherField.value.trim();
    // create new subject based on text from form
    _subject = Subject(
      nextID,
      subjectName,
      roomText,
      building,
      teacher,
      colorField.value,
      null, // initial schedule
    );
    subjectsRepo.addSubject(_subject);
    emitSuccess();
  }

  void _updateSubjectNames() {
    final allSubjects = subjectsRepo.subjects;
    _subjectNames =
        allSubjects.map((subject) => subject.name.toLowerCase()).toList();
  }

  void _updateTakenColors() {
    final subjectColors =
        subjectsRepo.subjects.map((subject) => subject.color).toList();
    _takenColors = subjectColors;
  }

  static String validateSubjectName(String name) {
    if (_subjectNames.contains(name.toLowerCase())) {
      return 'That subject already exists';
    }
    return null;
  }

  static String validateColor(Color color) {
    if (_takenColors.contains(color)) {
      return 'That color is already taken';
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
