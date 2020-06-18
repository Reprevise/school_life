import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/add_holiday_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/pages/schedule/widgets/holiday_item.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/util/date_utils.dart';

class ScheduleHolidaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            ExtendedNavigator.rootNavigator.pushNamed(Routes.addHoliday),
        label: const Text('Add Holiday'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: ValueListenableBuilder<Box<Holiday>>(
          valueListenable:
              Hive.box<Holiday>(Databases.holidaysBox).listenable(),
          builder: (context, box, _) {
            return Visibility(
              visible: box.isNotEmpty,
              child: ListView.separated(
                primary: false,
                padding: const EdgeInsets.all(16),
                itemCount: box.values.length,
                itemBuilder: (_, index) {
                  return HolidayItem(box.values.toList()[index]);
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 16);
                },
              ),
              replacement: ListView(
                primary: false,
                padding: const EdgeInsets.symmetric(vertical: 25),
                children: <Widget>[
                  Icon(
                    Icons.event,
                    color: Colors.grey[400],
                    size: 128.0,
                  ),
                  Text(
                    'You don\'t have any holidays!',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aww :(',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: fontSize / 1.2),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddHolidayPage extends StatefulWidget {
  @override
  _AddHolidayPageState createState() => _AddHolidayPageState();
}

class _AddHolidayPageState extends State<AddHolidayPage> {
  AddHolidayFormBloc _formBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FormBlocHelper<AddHolidayFormBloc>(
        create: (_) => AddHolidayFormBloc(),
        onSuccess: (_, __) {
          ExtendedNavigator.rootNavigator.pop();
        },
        onSubmitting: (_, __) {
          return const Center(child: CircularProgressIndicator());
        },
        onLoading: (_, __) {
          return const Center(child: CircularProgressIndicator());
        },
        builder: (context, state) {
          _formBloc = context.bloc<AddHolidayFormBloc>();
          return WillPopScope(
            onWillPop: () => _formBloc.canPop(context),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              children: <Widget>[
                const FormRequired(all: true),
                TextFieldBlocBuilder(
                  padding: EdgeInsets.zero,
                  textFieldBloc: _formBloc.holidayName,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Holiday name*',
                  ),
                ),
                const SizedBox(height: 8),
                DateTimeFieldBlocBuilder(
                  dateTimeFieldBloc: _formBloc.startDate,
                  format: DateFormat.yMMMd(),
                  initialDate: null,
                  firstDate: DateTime.now().onlyDate,
                  lastDate: DateTime.now().addYears(1),
                  decoration: InputDecoration(
                    labelText: 'Start date',
                  ),
                ),
                const SizedBox(height: 8),
                DateTimeFieldBlocBuilder(
                  dateTimeFieldBloc: _formBloc.endDate,
                  format: DateFormat.yMMMd(),
                  initialDate: null,
                  firstDate: DateTime.now().onlyDate,
                  lastDate: DateTime.now().addYears(1),
                  decoration: InputDecoration(
                    labelText: 'End date',
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  borderSide:
                      Theme.of(context).inputDecorationTheme.border.borderSide,
                  textColor: Theme.of(context).textTheme.subtitle2.color,
                  onPressed: _formBloc.submit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
