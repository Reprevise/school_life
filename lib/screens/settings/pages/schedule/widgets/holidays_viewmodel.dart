import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../util/popper.dart';
import '../../../../../models/holiday.dart';
import '../../../../../services/databases/holidays_repository.dart';

class AddHolidayViewModel extends BaseViewModel with Popper {
  final form = FormGroup({
    'holiday': FormControl(value: '', validators: [Validators.required]),
    'startDate': FormControl(validators: [Validators.required]),
    'endDate': FormControl(validators: [Validators.required]),
  });
  final holidaysRepository = locator<HolidaysRepository>();

  FormControl<String> get holidayName =>
      form.control('holiday') as FormControl<String>;
  FormControl<DateTime> get startDate =>
      form.control('startDate') as FormControl<DateTime>;
  FormControl<DateTime> get endDate =>
      form.control('endDate') as FormControl<DateTime>;

  Future<void> addHoliday() async {
    final holiday = Holiday(
      id: const Uuid().v4(),
      name: holidayName.value!,
      startDate: startDate.value!,
      endDate: endDate.value!,
    );
    await runBusyFuture(
      holidaysRepository.addHoliday(holiday),
      throwException: true,
    );
  }

  @override
  bool fieldsAreEmpty() {
    return startDate.isNull && endDate.isNull && holidayName.isNullOrEmpty;
  }
}
