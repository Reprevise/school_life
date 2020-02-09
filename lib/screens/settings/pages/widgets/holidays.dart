import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/add_holiday_bloc.dart';
import 'package:school_life/components/appbar/custom_appbar.dart';
import 'package:school_life/components/easy_bloc/easy_bloc.dart';
import 'package:school_life/routing/router.gr.dart';

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

class AddHoliday extends StatelessWidget {
  const AddHoliday({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Holiday'),
      body: BlocHelper<AddHolidayFormBloc>(
        create: (_) => AddHolidayFormBloc(),
        onSuccess: (_, __) {
          Router.navigator.pop();
        },
        builder: (BuildContext context, FormBlocState<String, String> state) {
          if (state is FormBlocLoading || state is FormBlocSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: <Widget>[
                Text(
                  '* All fields are required',
                  textAlign: TextAlign.right,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
