import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/add_holiday_bloc.dart';
import 'package:school_life/components/appbar/custom_appbar.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/pages/schedule/widgets/holiday_item.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScheduleHolidaysPage extends StatelessWidget {
  const ScheduleHolidaysPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;
    return Scaffold(
      appBar: const CustomAppBar('Configure Holidays'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Router.navigator.pushNamed(Router.addHoliday),
        label: const Text('ADD HOLIDAY'),
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
                  return HolidayItem(holiday: box.values.toList()[index]);
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
  const AddHolidayPage({Key key}) : super(key: key);

  @override
  _AddHolidayPageState createState() => _AddHolidayPageState();
}

class _AddHolidayPageState extends State<AddHolidayPage> {
  AddHolidayFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Holiday'),
      body: FormBlocHelper<AddHolidayFormBloc>(
        create: (_) => AddHolidayFormBloc(),
        onSuccess: (_, __) {
          Router.navigator.pop();
        },
        builder: (context, state) {
          if (state is FormBlocLoading || state is FormBlocSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            _formBloc = context.bloc<AddHolidayFormBloc>();
            return WillPopScope(
              onWillPop: () => _formBloc.canPop(context),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BlocBuilder<InputFieldBloc<DateTime>,
                          InputFieldBlocState<DateTime>>(
                        bloc: _formBloc.startDate,
                        builder: (context, state) {
                          return DateField(
                            labelText: 'Start date',
                            errorText: state.error,
                            selectedDate: state.value,
                            onDateChanged: (date) {
                              _formBloc.startDate.updateValue(date);
                            },
                            format: DateFormat.yMMMd(),
                            isRequired: true,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<InputFieldBloc<DateTime>,
                          InputFieldBlocState<DateTime>>(
                        bloc: _formBloc.endDate,
                        builder: (context, state) {
                          return DateField(
                            labelText: 'End date',
                            errorText: state.error,
                            selectedDate: state.value,
                            onDateChanged: (date) {
                              _formBloc.endDate.updateValue(date);
                            },
                            format: DateFormat.yMMMd(),
                            isRequired: true,
                          );
                        },
                      ),
                      OutlineButton(
                        padding: EdgeInsets.zero,
                        borderSide: Theme.of(context)
                            .inputDecorationTheme
                            .border
                            .borderSide,
                        textColor: Theme.of(context).textTheme.bodyText2.color,
                        onPressed: _formBloc.submit,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
