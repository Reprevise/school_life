import 'dart:convert';

import 'package:form_bloc/form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/models/user_settings.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/days_from_integer.dart';

class AddScheduleFormBloc extends FormBloc<String, dynamic> {
  SubjectsRepository subjects;

  AddScheduleFormBloc() : super(isLoading: true) {
    subjects = getIt<SubjectsRepository>();
  }

  // ignore: close_sinks
  final subjectField = SelectFieldBloc(
    validators: [FieldBlocValidators.requiredSelectFieldBloc],
  );

  // ignore: close_sinks
  final scheduleDaysField = MultiSelectFieldBloc<String>(
    validators: [FieldBlocValidators.requiredMultiSelectFieldBloc],
  );

  int oldNumberOfDays = 0;

  // ignore: close_sinks
  final sameTimeEveryday = BooleanFieldBloc(initialValue: false);

  final List<InputFieldBloc> startTimeFields = [], endTimeFields = [];

  final Map<int, FieldBloc> fields = {
    DateTime.monday: InputFieldBloc(toStringName: "Monday"),
  };

  @override
  List<FieldBloc> get fieldBlocs => [
        subjectField,
        scheduleDaysField,
        sameTimeEveryday,
        ...startTimeFields,
        ...endTimeFields,
      ];

  void addStartEndTimeFields() {
    startTimeFields.add(InputFieldBloc());
    endTimeFields.add(InputFieldBloc());
  }

  void removeStartEndTimeFields() {
    startTimeFields.removeLast();
    endTimeFields.removeLast();
  }

  void changeDays(MultiSelectFieldBlocState<String> state) {
    if (state.value.length > oldNumberOfDays)
      addStartEndTimeFields();
    else if (state.value.length < oldNumberOfDays) removeStartEndTimeFields();
    oldNumberOfDays = state.value.length;
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
    List<Subject> allSubjects = subjects.getAllSubjects();
    for (Subject subject in allSubjects) {
      subjectField.addItem(subject.name);
    }
    subjectField.updateInitialValue(allSubjects.first.name);
    yield state.toLoaded();
  }

  void getAvailableDays() {
    var box = Hive.box(DatabaseHelper.SETTINGS_BOX);
    Map<String, bool> map =
        json.decode(box.get(UserSettingsKeys.SCHOOL_DAYS)).cast<String, bool>();
    map.removeWhere((key, value) => value == false);
    List<String> days = map.keys
        .map<String>((dayStringInts) => daysFromIntegerString[dayStringInts])
        .toList();
    days.forEach((item) => scheduleDaysField.addItem(item));
  }
}
