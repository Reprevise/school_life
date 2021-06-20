import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../app/app.router.dart';
import '../../../../../components/forms/form_required.dart';
import '../../../../../components/forms/form_spacer.dart';
import '../../../../../models/holiday.dart';
import '../../../../../services/databases/hive_helper.dart';
import '../../../../../util/date_utils.dart';
import 'holiday_item.dart';
import 'holidays_viewmodel.dart';

class ScheduleHolidaysPage extends StatelessWidget {
  ScheduleHolidaysPage({Key? key}) : super(key: key);

  final _navService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navService.navigateTo(Routes.addHolidayPage),
        label: const Text('Add Holiday'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Holidays',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ValueListenableBuilder<Box<Holiday>>(
        valueListenable: Hive.box<Holiday>(HiveBoxes.holidaysBox).listenable(),
        builder: (context, box, _) {
          return Visibility(
            visible: box.isNotEmpty,
            replacement: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.event,
                  color: Colors.grey[400],
                  size: 128.0,
                ),
                const Text(
                  "You don't have any holidays!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            child: ListView.separated(
              primary: false,
              padding: const EdgeInsets.all(16),
              itemCount: box.values.length,
              itemBuilder: (_, index) {
                return HolidayItem(box.values.toList()[index]);
              },
              separatorBuilder: (_, __) {
                return const FormSpacer(large: true);
              },
            ),
          );
        },
      ),
    );
  }
}

class AddHolidayPage extends StatefulWidget {
  const AddHolidayPage({Key? key}) : super(key: key);

  @override
  _AddHolidayPageState createState() => _AddHolidayPageState();
}

class _AddHolidayPageState extends State<AddHolidayPage> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ViewModelBuilder<AddHolidayViewModel>.nonReactive(
      viewModelBuilder: () => AddHolidayViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: ReactiveForm(
            onWillPop: model.canPop,
            formGroup: model.form,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              children: <Widget>[
                const FormRequired(all: true),
                ReactiveTextField(
                  formControl: model.holidayName,
                  autofocus: true,
                  onEditingComplete: model.startDate.focus,
                  decoration: const InputDecoration(
                    labelText: 'Holiday name*',
                  ),
                ),
                const FormSpacer(),
                ReactiveDateTimePicker(
                  formControl: model.startDate,
                  valueAccessor: DateTimeValueAccessor(
                    dateTimeFormat: DateFormat.yMMMd(),
                  ),
                  firstDate: now.onlyDate,
                  lastDate: now.addYears(1),
                  fieldLabelText: 'Start date',
                ),
                const FormSpacer(),
                ReactiveDateTimePicker(
                  formControl: model.endDate,
                  valueAccessor: DateTimeValueAccessor(
                    dateTimeFormat: DateFormat.yMMMd(),
                  ),
                  firstDate: now.onlyDate,
                  lastDate: now.addYears(1),
                  fieldLabelText: 'End date',
                ),
                const FormSpacer(large: true),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    side: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide,
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color,
                    ),
                  ),
                  onPressed: model.addHoliday,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
