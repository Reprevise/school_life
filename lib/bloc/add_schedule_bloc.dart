import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/bloc/validators.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/settings_keys.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/days_util.dart';

class AddScheduleFormBloc extends FormBloc<String, String> with Popper {
  AddScheduleFormBloc() : super(isLoading: true) {
    _subjectsRepo = sl<SubjectsRepository>();
  }

  SubjectsRepository _subjectsRepo;

  final List<String> _availableDays = <String>[];
  List<String> get availableDays => _availableDays;

  final SelectFieldBloc<Map<String, dynamic>> _subjectField =
      SelectFieldBloc<Map<String, dynamic>>(
    validators: <String Function(Map<String, dynamic>)>[
      FieldBlocValidators.requiredSelectFieldBloc
    ],
  );
  SelectFieldBloc<Map<String, dynamic>> get subjectField => _subjectField;

  final List<Map<String, FieldBloc>> _scheduleFields =
      <Map<String, FieldBloc>>[];
  List<Map<String, FieldBloc>> get scheduleFields => _scheduleFields;

  @override
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        _subjectField,
        ..._scheduleFields
            .expand((Map<String, FieldBloc> map) => map.values)
            .toList(),
      ];

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    getAvailableDays();
    _availableDays.forEach(addScheduleField);
    _setSubjectFieldValues();
    yield state.toLoaded();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    final int subjectID = _subjectField.value['value'] as int;
    final Subject subject = _subjectsRepo.getSubject(subjectID);

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
    await subject.save();
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
    final LinkedHashMap<String, List<TimeOfDay>> resMap =
        LinkedHashMap<String, List<TimeOfDay>>();
    for (final String key in mapKeys) {
      resMap[key] = map[key];
    }
    return resMap;
  }

  void _setSubjectFieldValues() {
    final List<Subject> subjectsWithoutASchedule =
        _subjectsRepo.subjectsWithoutSchedule;
    for (final Subject subject in subjectsWithoutASchedule) {
      _subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
  }

  void getAvailableDays() {
    final Box<dynamic> box = Hive.box<dynamic>(Databases.SETTINGS_BOX);
    final String mapString = box.get(SettingsKeys.SCHOOL_DAYS) as String;
    Map<String, bool> map;
    if (mapString == null) {
      map = ScheduleSettingsDefaults.defaultDaysOfSchool;
    } else {
      map = jsonDecode(mapString) as Map<String, bool>;
    }
    map.removeWhere((_, bool value) => value == false);
    final List<String> days = map.keys
        .map((String dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach(_availableDays.add);
  }

  void addScheduleField(String day) {
    final List<Subject> subjects =
        _subjectsRepo.getSubjectsWithSameDaySchedule(day);
    final SelectFieldBloc<String> dayFieldBloc = SelectFieldBloc<String>(
      items: _availableDays,
      initialValue: day ?? _availableDays.first,
    );
    final InputFieldBloc<TimeOfDay> startTimeBloc = InputFieldBloc<TimeOfDay>(
      validators: <String Function(TimeOfDay)>[
        FieldBlocValidators.requiredInputFieldBloc,
        (TimeOfDay time) => Validators.notSameStartTime(time, day, subjects),
      ],
    );
    final InputFieldBloc<TimeOfDay> endTimeBloc = InputFieldBloc<TimeOfDay>(
      validators: <String Function(TimeOfDay)>[
        FieldBlocValidators.requiredInputFieldBloc,
      ],
    );
    final Map<String, FieldBloc> value = <String, FieldBloc>{
      'dayFieldBloc': dayFieldBloc,
      'startTimeBloc': startTimeBloc,
      'endTimeBloc': endTimeBloc,
    };
    scheduleFields.add(value);
  }

  @override
  bool fieldsAreEmpty() {
    if (subjectField.value == null) {
      if (_scheduleFields
          .expand((Map<String, FieldBloc> map) => map.values)
          .toList()
          .isEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }
}
