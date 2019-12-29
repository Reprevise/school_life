import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AddScheduleFormBloc extends FormBloc<String, dynamic> {
  AddScheduleFormBloc() : super(isLoading: true);

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

  final List<InputFieldBloc> startEndTimeFields = [];

  @override
  List<FieldBloc> get fieldBlocs => [
        subjectField,
        scheduleDaysField,
        sameTimeEveryday,
        ...startEndTimeFields,
      ];

  void addStartEndTimeFields() {
    startEndTimeFields.add(InputFieldBloc());
    startEndTimeFields.add(InputFieldBloc());
  }

  void removeStartEndTimeFields() {
    startEndTimeFields.removeLast();
    startEndTimeFields.removeLast();
  }

  void changeDays(MultiSelectFieldBlocState<String> state) {
    print("changing days");
    if (state.value.length > oldNumberOfDays) addStartEndTimeFields();
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
    List<Subject> subjects = SubjectsRepository.getAllSubjects();
    for (Subject subject in subjects) {
      subjectField.addItem(subject.name);
    }
    subjectField.updateInitialValue(subjects.first.name);
    yield state.toLoaded();
  }
}
