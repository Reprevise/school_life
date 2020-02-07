import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/models/user_settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/days_util.dart';

class AddScheduleFormBloc extends FormBloc<String, dynamic> {
  AddScheduleFormBloc() : super(isLoading: true) {
    subjects = getIt<SubjectsRepository>();
  }

  SubjectsRepository subjects;
  List<String> availableDays = <String>[];

  final SelectFieldBloc<Map<String, dynamic>> subjectField =
      SelectFieldBloc<Map<String, dynamic>>(
    validators: <String Function(Map<String, dynamic>)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );

  List<Map<String, FieldBloc>> scheduleFields = <Map<String, FieldBloc>>[];

  @override
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        subjectField,
        ...scheduleFields
            .expand((Map<String, FieldBloc> map) => map.values)
            .toList(),
      ];

  @override
  Stream<FormBlocState<String, dynamic>> onLoading() async* {
    getAvailableDays();
    availableDays.forEach(addScheduleField);
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
    getAvailableDays();
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onSubmitting() async* {
    final int subjectID = subjectField.value['value'] as int;
    final Subject subject = subjects.getSubject(subjectID);

    for (final Map<String, FieldBloc> field in scheduleFields) {
      final SelectFieldBloc<String> dayFieldBloc =
          field['dayFieldBloc'] as SelectFieldBloc<String>;
      final InputFieldBloc<TimeOfDay> startTimeBloc =
          field['startTimeBloc'] as InputFieldBloc<TimeOfDay>;
      final InputFieldBloc<TimeOfDay> endTimeBloc =
          field['endTimeBloc'] as InputFieldBloc<TimeOfDay>;
      final String day = dayFieldBloc.value;
      final TimeOfDay startTime = startTimeBloc.value;
      final TimeOfDay endTime = endTimeBloc.value;
      subject.schedule ??= <String, List<TimeOfDay>>{};
      subject.schedule[day] = <TimeOfDay>[startTime, endTime];
    }
    subject.schedule = sortMap(
      LinkedHashMap<String, List<TimeOfDay>>.from(subject.schedule),
    );
    print('Schedule: ${subject.schedule}');
    subject.save();
    yield state.toSuccess();
  }

  LinkedHashMap<String, List<TimeOfDay>> sortMap(
      LinkedHashMap<String, List<TimeOfDay>> map) {
    final List<String> mapKeys = map.keys.toList()
      ..sort((String stringOne, String stringTwo) {
        final int numberOne = daysToInteger[stringOne];
        final int numberTwo = daysToInteger[stringTwo];
        return numberOne.compareTo(numberTwo);
      });
    print('Map Keys: $mapKeys');
    final LinkedHashMap<String, List<TimeOfDay>> resMap =
        LinkedHashMap<String, List<TimeOfDay>>();
    for (final String key in mapKeys) {
      resMap[key] = map[key];
    }
    return resMap;
  }

  Stream<FormBlocState<String, dynamic>> _setSubjectFieldValues() async* {
    final List<Subject> allSubjects = subjects.allSubjects;
    for (final Subject subject in allSubjects) {
      subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
    yield state.toLoaded();
  }

  void getAvailableDays() {
    final Box<dynamic> box = Hive.box<dynamic>(Databases.SETTINGS_BOX);
    final String mapString = box.get(UserSettingsKeys.SCHOOL_DAYS) as String;
    Map<String, bool> map;
    if (mapString == null) {
      map = ScheduleSettingsDefaults.defaultDaysOfSchool;
    } else {
      map = jsonDecode(mapString).cast<String, bool>() as Map<String, bool>;
    }
    map.removeWhere((String key, bool value) => value == false);
    final List<String> days = map.keys
        .map<String>(
            (String dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach(availableDays.add);
  }

  void addScheduleField(String day) {
    final SelectFieldBloc<String> dayFieldBloc = SelectFieldBloc<String>(
      items: availableDays,
      initialValue: day ?? availableDays.first,
    );
    scheduleFields.add(<String, FieldBloc>{
      'dayFieldBloc': dayFieldBloc,
      'startTimeBloc': InputFieldBloc<TimeOfDay>(
        validators: <String Function(TimeOfDay)>[
          FieldBlocValidators.requiredInputFieldBloc,
          (TimeOfDay time) => Validators.notSameStartTime(time, dayFieldBloc.value),
        ],
      ),
      'endTimeBloc': InputFieldBloc<TimeOfDay>(
        validators: <String Function(TimeOfDay)>[
          FieldBlocValidators.requiredInputFieldBloc,
        ],
      ),
    });
  }
}
