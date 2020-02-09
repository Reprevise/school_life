import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/add_holiday_bloc.dart';
import 'package:school_life/components/appbar/custom_appbar.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/required/form_required.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/util/date_utils.dart';

class ScheduleHolidaysPage extends StatelessWidget {
  const ScheduleHolidaysPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Configure Holidays'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Router.navigator.push(
          MaterialPageRoute<AddHoliday>(
            builder: (_) => const AddHoliday(),
          ),
        ),
        label: const Text('ADD HOLIDAY'),
        icon: Icon(Icons.add),
      ),
      body: ListView(),
    );
  }
}

class AddHoliday extends StatefulWidget {
  const AddHoliday({Key key}) : super(key: key);

  @override
  _AddHolidayState createState() => _AddHolidayState();
}

class _AddHolidayState extends State<AddHoliday> {
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
        builder: (BuildContext context, FormBlocState<String, String> state) {
          if (state is FormBlocLoading || state is FormBlocSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            _formBloc = BlocProvider.of<AddHolidayFormBloc>(context);
            return WillPopScope(
              onWillPop: () => _formBloc.canPop(context),
              child: ListView(
                children: <Widget>[
                  const FormRequired(all: true),
                  TextFieldBlocBuilder(
                    textFieldBloc: _formBloc.holidayName,
                  ),
                  BlocBuilder<InputFieldBloc<DateTime>,
                      InputFieldBlocState<DateTime>>(
                    bloc: _formBloc.startDate,
                    builder: (BuildContext context,
                        InputFieldBlocState<DateTime> state) {
                      return DateField(
                        labelText: 'Start date',
                        errorText: state.error,
                        selectedDate: DateTime.now().onlyDate,
                        onDateChanged: (DateTime date) {
                          _formBloc.startDate.updateValue(date);
                        },
                        format: DateFormat.yMMMd(),
                        isRequired: true,
                      );
                    },
                  ),
                  BlocBuilder<InputFieldBloc<DateTime>,
                      InputFieldBlocState<DateTime>>(
                    bloc: _formBloc.endDate,
                    builder: (BuildContext context,
                        InputFieldBlocState<DateTime> state) {
                      return DateField(
                        labelText: 'End date',
                        errorText: state.error,
                        selectedDate: DateTime.now().onlyDate,
                        onDateChanged: (DateTime date) {
                          _formBloc.endDate.updateValue(date);
                        },
                        format: DateFormat.yMMMd(),
                        isRequired: true,
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: OutlineButton(
                      padding: EdgeInsets.zero,
                      borderSide: Theme.of(context)
                          .inputDecorationTheme
                          .border
                          .borderSide,
                      textColor: Theme.of(context).textTheme.bodyText2.color,
                      onPressed: _formBloc.submit,
                      child: const Text('Submit'),
                    ),
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
