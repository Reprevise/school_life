import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/popper.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/services/databases/holidays_repository.dart';
import 'package:school_life/util/date_utils.dart';

class AddHolidayFormBloc extends FormBloc<String, String> with Popper {
  AddHolidayFormBloc() : super(isLoading: true) {
    _holidaysRepo = sl<HolidaysRepository>();
    addFieldBlocs(fieldBlocs: [_holidayName, _startDate, _endDate]);
  }

  HolidaysRepository _holidaysRepo;
  static List<String> _holidayNames = <String>[];

  final TextFieldBloc _holidayName = TextFieldBloc(
    name: 'holiday-name',
    initialValue: '',
    validators: [
      FieldBlocValidators.required,
      validateHolidayName,
    ],
  );
  TextFieldBloc get holidayName => _holidayName;

  final _startDate = InputFieldBloc<DateTime, Object>(
    name: 'holiday-start_date',
    validators: [FieldBlocValidators.required],
    initialValue: DateTime.now().onlyDate,
  );
  InputFieldBloc<DateTime, Object> get startDate => _startDate;

  final _endDate = InputFieldBloc<DateTime, Object>(
    name: 'holiday-end_date',
    validators: [FieldBlocValidators.required],
    initialValue: DateTime.now().onlyDate,
  );
  InputFieldBloc<DateTime, Object> get endDate => _endDate;

  @override
  void onLoading() {
    _getHolidayNames();
    emitLoaded();
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
  void onSubmitting() async {
    final name = _holidayName.value.trim();
    final nextID = _holidaysRepo.nextID;
    final holiday = Holiday(nextID, name, _startDate.value, _endDate.value);
    await _holidaysRepo.addHoliday(holiday);
    emitSuccess();
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
