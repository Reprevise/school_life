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
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/day_utils.dart';

class AddScheduleFormBloc extends FormBloc<String, String> with Popper {
  AddScheduleFormBloc() : super(isLoading: true) {
    _subjectsRepo = sl<SubjectsRepository>();
    addFieldBloc(fieldBloc: _subjectField);
    addFieldBloc(
      fieldBloc: FieldBlocList(
        name: 'schedules',
        fieldBlocs: [],
      ),
    );
  }

  SubjectsRepository _subjectsRepo;

  final List<String> _availableDays = <String>[];
  List<String> get availableDays => _availableDays;

  final SelectFieldBloc _subjectField = SelectFieldBloc<Map<String, dynamic>>(
    name: 'schedule-subject',
    validators: [FieldBlocValidators.requiredSelectFieldBloc],
  );

  // final List<Map<String, FieldBloc>> _scheduleFields =
  //     <Map<String, FieldBloc>>[];
  // List<Map<String, FieldBloc>> get scheduleFields => _scheduleFields;

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    getAvailableDays();
    _availableDays.forEach(addScheduleField);
    _setSubjectFieldValues();
    yield state.toLoaded();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    final subjectID = _subjectField.value['value'] as int;
    final subject = _subjectsRepo.getSubject(subjectID);

    for (final field in state.fieldBlocFromPath('schedules').asFieldBlocList) {
      final dayFieldBloc =
          field.asGroupFieldBloc['schedule-day'].asSelectFieldBloc<String>();
      final startTimeBloc = field.asGroupFieldBloc['schedule-start_time']
          .asInputFieldBloc<TimeOfDay>();
      final endTimeBloc = field.asGroupFieldBloc['schedule-end_time']
          .asInputFieldBloc<TimeOfDay>();
      final day = dayFieldBloc.value;
      final startTime = startTimeBloc.value;
      final endTime = endTimeBloc.value;
      subject.schedule ??= {};
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
    final mapKeys = map.keys.toList()
      ..sort(
        (stringOne, stringTwo) {
          final numberOne = daysToInteger[stringOne];
          final numberTwo = daysToInteger[stringTwo];
          return numberOne.compareTo(numberTwo);
        },
      );
    final resMap = <String, List<TimeOfDay>>{};
    for (final key in mapKeys) {
      resMap[key] = map[key];
    }
    return resMap;
  }

  void _setSubjectFieldValues() {
    final subjectsWithoutASchedule = _subjectsRepo.subjectsWithoutSchedule;
    for (final subject in subjectsWithoutASchedule) {
      _subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
  }

  void getAvailableDays() {
    final box = Hive.box<dynamic>(Databases.settingsBox);
    final mapString = box.get(SettingsKeys.schoolDays) as String;
    Map<String, bool> map;
    if (mapString == null) {
      map = Map<String, bool>.from(ScheduleSettingsDefaults.daysOfSchool);
    } else {
      map = Map<String, bool>.from(
        jsonDecode(mapString) as Map<dynamic, dynamic>,
      );
    }
    map.removeWhere((_, value) => value == false);
    final days = map.keys
        .map((dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach(_availableDays.add);
  }

  void addScheduleField(String day) {
    final subjects = _subjectsRepo.getSubjectsWithSameDaySchedule(day);

    final dayFieldBloc = SelectFieldBloc<String>(
      name: 'schedule-day',
      items: _availableDays,
      initialValue: day ?? _availableDays.first,
    );
    final startTimeBloc = InputFieldBloc<TimeOfDay>(
      name: 'schedule-start_time',
      validators: <String Function(TimeOfDay)>[
        FieldBlocValidators.requiredInputFieldBloc,
        (time) => Validators.notSameStartTime(time, day, subjects),
      ],
    );
    final endTimeBloc = InputFieldBloc<TimeOfDay>(
      name: 'schedule-end_time',
      validators: <String Function(TimeOfDay)>[
        FieldBlocValidators.requiredInputFieldBloc,
      ],
    );
    addFieldBloc(
      path: 'schedules',
      fieldBloc: GroupFieldBloc(
        name: 'schedule',
        fieldBlocs: [
          dayFieldBloc,
          startTimeBloc,
          endTimeBloc,
        ],
      ),
    );
    // final value = <String, FieldBloc>{
    //   'dayFieldBloc': dayFieldBloc,
    //   'startTimeBloc': startTimeBloc,
    //   'endTimeBloc': endTimeBloc,
    // };
    // _scheduleFields.add(value);
  }

  void removeScheduleField(int index) {
    removeFieldBloc(path: 'schedules/[$index]');
  }

  @override
  bool fieldsAreEmpty() {
    if (_subjectField.value == null) {
      for (final bloc in state.fieldBlocFromPath('schedules').asFieldBlocList) {
        if (bloc is SelectFieldBloc) {
          var value = bloc.asSelectFieldBloc().value;
          if (value != null) {
            return false;
          }
        } else if (bloc is InputFieldBloc) {
          var value = bloc.asInputFieldBloc().value;
          if (value != null) {
            return false;
          }
        }
      }
      return true;
    }
    return false;
  }
}
