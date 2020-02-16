import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/services/databases/holidays_repository.dart';
import 'package:school_life/util/date_utils.dart';

class AddHolidayFormBloc extends FormBloc<String, String> with Popper {
  AddHolidayFormBloc() : super(isLoading: true) {
    _holidaysRepo = sl<HolidaysRepository>();
  }

  HolidaysRepository _holidaysRepo;
  // TODO: make a validator that ensures a unique holiday name
  static List<String> _holidayNames = <String>[];

  final TextFieldBloc _holidayName = TextFieldBloc(
    initialValue: '',
    validators: <String Function(String)>[
      FieldBlocValidators.requiredTextFieldBloc,
      validateHolidayName,
    ],
  );
  TextFieldBloc get holidayName => _holidayName;

  final InputFieldBloc<DateTime> _startDate = InputFieldBloc<DateTime>(
    validators: <String Function(DateTime)>[
      FieldBlocValidators.requiredInputFieldBloc,
    ],
    initialValue: DateTime.now().onlyDate,
  );
  InputFieldBloc<DateTime> get startDate => _startDate;

  final InputFieldBloc<DateTime> _endDate = InputFieldBloc<DateTime>(
    validators: <String Function(DateTime)>[
      FieldBlocValidators.requiredInputFieldBloc,
    ],
    initialValue: DateTime.now().onlyDate,
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
    _holidayNames =
        _holidaysRepo.holidays.map((e) => e.name.toLowerCase()).toList();
  }

  static String validateHolidayName(String name) {
    if (_holidayNames.contains(name.toLowerCase())) {
      return 'Holiday name already exists!';
    }
    return null;
  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    final name = _holidayName.value.trim();
    final nextID = _holidaysRepo.nextID;
    final holiday = Holiday(nextID, name, _startDate.value, _endDate.value);
    await _holidaysRepo.addHoliday(holiday);
    yield state.toSuccess();
  }

  @override
  bool fieldsAreEmpty() {
    final name = _holidayName.value.trim();
    final startEmpty = _startDate.state.isInitial || _startDate.value == null;
    final endEmpty = _endDate.state.isInitial || _endDate.value == null;

    if (name.isEmpty && startEmpty && endEmpty) {
      return true;
    }
    return false;
  }
}
