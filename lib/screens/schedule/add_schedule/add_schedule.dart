import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/forms/page_navigator.dart';
import 'package:school_life/components/index.dart';

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
        "Add Schedule",
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      drawer: CustomDrawer(),
      body: BlocProvider<AddScheduleFormBloc>(
        builder: (context) => AddScheduleFormBloc(),
        child: Builder(builder: (context) {
          _formBloc = BlocProvider.of<AddScheduleFormBloc>(context);
          return FormBlocListener<AddScheduleFormBloc, String, dynamic>(
            onSuccess: (context, state) {
              Navigator.of(context).pushNamed("/schedule");
            },
            child: BlocBuilder<AddScheduleFormBloc, FormBlocState>(
              builder: (context, state) {
                if (state is FormBlocLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FormBlocLoadFailed) {
                  return Center(child: Text("Uh oh! Try again later"));
                } else {
                  return PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
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
  final AddScheduleFormBloc formBloc;

  _FirstPage(this.formBloc);

  @override
  Widget build(BuildContext context) {
    num cWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What subject do you want to create a schedule for?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: DropdownFieldBlocBuilder(
                selectFieldBloc: formBloc.subjectField,
                millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                itemBuilder: (context, value) => value,
                showEmptyItem: false,
                decoration: InputDecoration(
                  labelText: "Subject",
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
    num cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What days do you have this subject on?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Center(
            child: CheckboxGroupFieldBlocBuilder<String>(
              multiSelectFieldBloc: formBloc.scheduleDaysField,
              itemBuilder: (context, value) => value,
              decoration: InputDecoration(
                labelText: "Days",
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
    num cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What times do you have this subject?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: formBloc.startTimeFields.map((field) {
                        return BlocBuilder(
                          bloc: field[1],
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TimeField(
                                labelText: "Start time",
                                onTimeChanged: (value) =>
                                    field[1].updateValue(value),
                                errorText: field[1].state.error,
                                selectedTime: field[1].value,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: formBloc.endTimeFields.map((field) {
                        return BlocBuilder(
                          bloc: field[1],
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TimeField(
                                labelText: "${field[0]} end time",
                                onTimeChanged: (value) =>
                                    field[1].updateValue(value),
                                errorText: field[1].state.error,
                                selectedTime: field[1].value,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
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
