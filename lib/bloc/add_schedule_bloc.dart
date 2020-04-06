import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
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
    addFieldBlocs(fieldBlocs: [subjectField, schedule]);
  }

  final schedule = ListFieldBloc<DayScheduleField>(name: 'schedules');

  SubjectsRepository _subjectsRepo;

  final List<String> _availableDays = <String>[];
  // List<String> get availableDays => _availableDays;

  final subjectField = SelectFieldBloc<Map<String, dynamic>, Object>(
    name: 'schedule-subject',
    validators: [FieldBlocValidators.required],
  );

  @override
  void onLoading() {
    _getAvailableDays();
    _availableDays.forEach(addScheduleField);
    _setSubjectFieldValues();
    emitLoaded();
  }

  @override
  void onSubmitting() async {
    final subjectID = subjectField.value['value'] as int;
    final subject = _subjectsRepo.getSubject(subjectID);

    for (final field in schedule.value) {
      final day = field.day.value;
      final startTime = field.startTime.value;
      final endTime = field.endTime.value;
      subject.schedule ??= {};
      subject.schedule[day] = <TimeOfDay>[startTime, endTime];
    }
    subject.schedule = sortMap(
      LinkedHashMap<String, List<TimeOfDay>>.from(subject.schedule),
    );
    await subject.save();
    emitSuccess();
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
      subjectField.addItem(<String, dynamic>{
        'name': subject.name,
        'value': subject.id,
      });
    }
  }

  void _getAvailableDays() {
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
    map.removeWhere((_, isAvailable) => isAvailable == false);
    final days = map.keys
        .map((dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach(_availableDays.add);
  }

  void addScheduleField(String day) {
    assert(day != null);
    final subjects = _subjectsRepo.getSubjectsWithSameDaySchedule(day);

    schedule.addFieldBloc(DayScheduleField(
      day: SelectFieldBloc(
        name: 'schedule-day',
        items: _availableDays,
        initialValue: day,
      ),
      startTime: InputFieldBloc<TimeOfDay, Object>(
        name: 'schedule-start_time',
        validators: [
          FieldBlocValidators.required,
          (time) => Validators.notSameStartTime(time, day, subjects),
        ],
      ),
      endTime: InputFieldBloc<TimeOfDay, Object>(
        name: 'schedule-end_time',
        validators: [FieldBlocValidators.required],
      ),
    ));
  }

  void removeScheduleField(int index) => schedule.removeFieldBlocAt(index);

  @override
  bool fieldsAreEmpty() {
    if (subjectField.value == null) {
      for (final bloc in schedule.value) {
        final dayValue = bloc.day.value;
        final startTime = bloc.startTime.value;
        final endTime = bloc.endTime.value;
        if (dayValue != null || startTime != null || endTime != null) {
          return false;
        }
        if (dayValue.isEmpty) return false;
      }
      return true;
    }
    return false;
  }
}

class DayScheduleField extends GroupFieldBloc {
  final SelectFieldBloc<String, Object> day;
  final InputFieldBloc<TimeOfDay, Object> startTime;
  final InputFieldBloc<TimeOfDay, Object> endTime;
  final String name;

  DayScheduleField({
    @required this.day,
    @required this.startTime,
    @required this.endTime,
    this.name,
  }) : super([day, startTime, endTime], name: name);
}
