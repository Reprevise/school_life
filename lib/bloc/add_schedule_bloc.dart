import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/models/user_settings.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/days_from_integer.dart';

class AddScheduleFormBloc extends FormBloc<String, dynamic> {
  AddScheduleFormBloc() : super(isLoading: true) {
    subjects = getIt<SubjectsRepository>();
  }

  SubjectsRepository subjects;

  final SelectFieldBloc<String> subjectField = SelectFieldBloc<String>(
    validators: <String Function(String)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );

  final MultiSelectFieldBloc<String> scheduleDaysField =
      MultiSelectFieldBloc<String>(
    validators: <String Function(List<String>)>[
      FieldBlocValidators.requiredMultiSelectFieldBloc
    ],
  );

  int oldNumberOfDays = 0;

  final BooleanFieldBloc sameTimeEveryday =
      BooleanFieldBloc(initialValue: false);

  final List<InputFieldBloc<TimeOfDay>> startTimeFields =
          <InputFieldBloc<TimeOfDay>>[],
      endTimeFields = <InputFieldBloc<TimeOfDay>>[];

  final Map<int, FieldBloc> fields = <int, FieldBloc>{
    DateTime.monday: InputFieldBloc<DateTime>(toStringName: 'Monday'),
  };

  @override
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        subjectField,
        scheduleDaysField,
        sameTimeEveryday,
        ...startTimeFields,
        ...endTimeFields,
      ];

  void addStartEndTimeFields(String day) {
    startTimeFields.add(InputFieldBloc<TimeOfDay>(toStringName: day));
    endTimeFields.add(InputFieldBloc<TimeOfDay>(toStringName: day));
  }

  void changeDays(MultiSelectFieldBlocState<String> state) {
    startTimeFields.clear();
    endTimeFields.clear();
    state.value.forEach(addStartEndTimeFields);
  }

  @override
  Stream<FormBlocState<String, dynamic>> onLoading() async* {
    getAvailableDays();
    scheduleDaysField.listen(changeDays);
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
    getAvailableDays();
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    // TODO: onSubmitting()
    yield state.toSuccess();
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    final List<Subject> allSubjects = subjects.getAllSubjects();
    for (Subject subject in allSubjects) {
      subjectField.addItem(subject.name);
    }
    subjectField.updateInitialValue(allSubjects.first.name);
    yield state.toLoaded();
  }

  void getAvailableDays() {
    final Box<dynamic> box = Hive.box<dynamic>(DatabaseHelper.SETTINGS_BOX);
    final String mapString = box.get(UserSettingsKeys.SCHOOL_DAYS) as String;
    final Map<String, bool> map = json.decode(mapString) as Map<String, bool>;
    map.removeWhere((String key, bool value) => value == false);
    final List<String> days = map.keys
        .map<String>(
            (String dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach(scheduleDaysField.addItem);
  }
}
