import 'package:form_bloc/form_bloc.dart';

class AddHolidayFormBloc extends FormBloc<String, String> {
  final List<String> _holidayNames = <String>[];

  @override
  // TODO: implement fieldBlocs
  List<FieldBloc> get fieldBlocs => throw UnimplementedError();

  @override
  Stream<FormBlocState<String, String>> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }
}
