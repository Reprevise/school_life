import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/forms/page_navigator.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/scroll_behavior/no_glow.dart';

final PageController _controller = PageController();

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  AddScheduleFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Add Schedule',
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      drawer: CustomDrawer(),
      body: BlocProvider<AddScheduleFormBloc>(
        create: (BuildContext context) => AddScheduleFormBloc(),
        child: Builder(builder: (BuildContext context) {
          _formBloc = BlocProvider.of<AddScheduleFormBloc>(context);
          return FormBlocListener<AddScheduleFormBloc, String, dynamic>(
            onSuccess: (BuildContext context, dynamic state) {
              Navigator.of(context).pushNamed('/schedule');
            },
            child: BlocBuilder<AddScheduleFormBloc, dynamic>(
              builder: (BuildContext context, dynamic state) {
                if (state is FormBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FormBlocLoadFailed) {
                  return const Center(child: Text('Uh oh! Try again later'));
                } else {
                  return PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _FirstPage(_formBloc),
                      _SecondPage(_formBloc),
                      _ThirdPage(_formBloc),
                    ],
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage(this.formBloc);

  final AddScheduleFormBloc formBloc;

  @override
  Widget build(BuildContext context) {
    final double cWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'What subject do you want to create a schedule for?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.subjectField,
                millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                itemBuilder: (BuildContext context, String value) => value,
                showEmptyItem: false,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(
                    Icons.subject,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ),
        PageNavigator(
          _controller,
          firstPage: true,
        ),
      ],
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage(this.formBloc);

  final AddScheduleFormBloc formBloc;

  @override
  Widget build(BuildContext context) {
    final double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'What days do you have this subject on?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Center(
            child: CheckboxGroupFieldBlocBuilder<String>(
              multiSelectFieldBloc: formBloc.scheduleDaysField,
              itemBuilder: (BuildContext context, String value) => value,
              decoration: InputDecoration(
                labelText: 'Days',
                prefixIcon: Icon(
                  Icons.view_day,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
        PageNavigator(_controller),
      ],
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage(this.formBloc);

  final AddScheduleFormBloc formBloc;

  @override
  Widget build(BuildContext context) {
    final double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'What times do you have this subject?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        // TODO: sort fields by day
        Expanded(
          child: Center(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowScrollBehavior(),
                    child: ListView.builder(
                      itemCount: formBloc.startTimeFields.length,
                      itemBuilder: (BuildContext context, int index) {
                        final InputFieldBloc<TimeOfDay> currentField =
                            formBloc.startTimeFields[index];
                        return BlocBuilder<InputFieldBloc<TimeOfDay>, dynamic>(
                          bloc: currentField,
                          builder: (BuildContext context, dynamic state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TimeField(
                                labelText:
                                    '${currentField.state.toStringName} start time',
                                onTimeChanged: (TimeOfDay value) =>
                                    currentField.updateValue(value),
                                errorText: currentField.state.error,
                                selectedTime: currentField.value,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowScrollBehavior(),
                    child: ListView.builder(
                      itemCount: formBloc.endTimeFields.length,
                      itemBuilder: (BuildContext context, int index) {
                        final InputFieldBloc<TimeOfDay> currentField =
                            formBloc.endTimeFields[index];
                        return BlocBuilder<InputFieldBloc<TimeOfDay>, dynamic>(
                          bloc: currentField,
                          builder: (BuildContext context, dynamic state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TimeField(
                                labelText:
                                    '${currentField.state.toStringName} end time',
                                onTimeChanged: (TimeOfDay value) =>
                                    currentField.updateValue(value),
                                errorText: currentField.state.error,
                                selectedTime: currentField.value,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        PageNavigator(
          _controller,
          finalPage: true,
          onSubmit: formBloc.submit,
        ),
      ],
    );
  }
}
