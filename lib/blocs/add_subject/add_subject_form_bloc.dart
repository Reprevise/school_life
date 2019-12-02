import 'package:flutter/cupertino.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/ui/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';

class AddSubjectFormBloc extends FormBloc<String, String> {
  final nameField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
    (val) {
      if (val.length > 22)
        return 'Subject name cannot be longer than 22 characters';
      return null;
    }
  ]);
  final roomField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
  ]);
  final buildingField = TextFieldBloc();
  final teacherField = TextFieldBloc(validators: [
    FieldBlocValidators.requiredTextFieldBloc,
  ]);
  final colorField = InputFieldBloc();

  AddSubjectFormBloc() {
    nameField.addAsyncValidators([subjectNameValid]);
  }

  @override
  List<FieldBloc> get fieldBlocs =>
      [nameField, roomField, buildingField, teacherField];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    yield state.toSuccess();
  }

  Future<bool> canPop(BuildContext context) {
    if (_fieldsAreEmpty()) return Future.value(true);
    DialogOnPop.showPopupDialog(context);
    return Future.value(false);
  }

  Future<String> subjectNameValid(String name) async {
    if (await RepositoryServiceSubject.checkIfSubNameExists(name))
      return 'That subject already exists';
    return null;
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String name = nameField.value.trim();
    String room = roomField.value.trim();
    String building = buildingField.value.trim();
    String teacher = teacherField.value.trim();
    var subjectColor = colorField.value;
    // if they're all empty, return true
    if (name.isEmpty &&
        room.isEmpty &&
        building.isEmpty &&
        teacher.isEmpty &&
        subjectColor != null) return true;
    // otherwise, return false
    return false;
  }
}
