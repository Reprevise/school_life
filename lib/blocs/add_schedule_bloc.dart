import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

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
  final scheduleDaysField = MultiSelectFieldBloc(
    validators: [FieldBlocValidators.requiredMultiSelectFieldBloc],
    items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
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
    scheduleDaysField.listen(changeDays);
    yield* _setSubjectFieldValues();
  }

  @override
  Stream<FormBlocState<String, dynamic>> onReload() async* {
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
}
