import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/services/databases/holidays_repository.dart';

class AddHolidayFormBloc extends FormBloc<String, String> with Popper {
  AddHolidayFormBloc() : super(isLoading: true) {
    _holidaysRepo = sl<HolidaysRepository>();
  }

  HolidaysRepository _holidaysRepo;
  // TODO: make a validator that ensures a unique holiday name
  List<String> _holidayNames = <String>[];

  final TextFieldBloc _holidayName = TextFieldBloc(
    initialValue: '',
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
    ],
  );
  TextFieldBloc get holidayName => _holidayName;

  final InputFieldBloc<DateTime> _startDate = InputFieldBloc<DateTime>(
    validators: <String Function(DateTime)>[
      FieldBlocValidators.requiredInputFieldBloc,
    ],
  );
  InputFieldBloc<DateTime> get startDate => _startDate;

  final InputFieldBloc<DateTime> _endDate = InputFieldBloc<DateTime>(
    validators: <String Function(DateTime)>[
      FieldBlocValidators.requiredInputFieldBloc,
    ],
  );
  InputFieldBloc<DateTime> get endDate => _endDate;

  @override
  List<FieldBloc> get fieldBlocs => <FieldBloc>[
        _holidayName,
        _startDate,
        _endDate,
      ];

  @override
  Stream<FormBlocState<String, String>> onLoading() async* {
    _getHolidayNames();
    yield state.toLoaded();
  }

  void _getHolidayNames() {
    _holidayNames = _holidaysRepo.holidays.map((Holiday e) => e.name).toList();
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }

  @override
  bool fieldsAreEmpty() {
    final String name = _holidayName.value.trim();
    final DateTime start = _startDate.value;
    final DateTime end = _endDate.value;

    if (name.isEmpty && start == null && end == null) {
      return true;
    }
    return false;
  }
}
