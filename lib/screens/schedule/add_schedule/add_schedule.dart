import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/page_navigator.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/screens/schedule/add_schedule/widgets/schedule_field.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  AddScheduleFormBloc _formBloc;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _formBloc?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Schedule'),
      body: BlocProvider<AddScheduleFormBloc>(
        create: (BuildContext context) => AddScheduleFormBloc(),
        child: Builder(builder: (BuildContext context) {
          _formBloc = BlocProvider.of<AddScheduleFormBloc>(context);
          return FormBlocListener<AddScheduleFormBloc, String, dynamic>(
            onSuccess:
                (BuildContext context, FormBlocSuccess<String, dynamic> state) {
              Router.navigator.pushNamed(Router.schedule);
            },
            child: BlocBuilder<AddScheduleFormBloc,
                FormBlocState<String, dynamic>>(
              builder:
                  (BuildContext context, FormBlocState<String, dynamic> state) {
                if (state is FormBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FormBlocLoadFailed) {
                  return const Center(child: Text('Uh oh! Try again later'));
                } else {
                  return PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _FirstPage(_formBloc, _controller),
                      _SecondPage(_formBloc, _controller),
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
  const _FirstPage(this.formBloc, this.controller);

  final AddScheduleFormBloc formBloc;
  final PageController controller;

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
              child: DropdownFieldBlocBuilder<Map<String, dynamic>>(
                selectFieldBloc: formBloc.subjectField,
                millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                itemBuilder:
                    (BuildContext context, Map<String, dynamic> value) =>
                        value['name'] as String,
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
          controller,
          isFirstPage: true,
        ),
      ],
    );
  }
}

class _SecondPage extends StatefulWidget {
  const _SecondPage(this.formBloc, this.controller);

  final AddScheduleFormBloc formBloc;
  final PageController controller;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<_SecondPage> {
  @override
  Widget build(BuildContext context) {
    final double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'Let\'s setup the schedule',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Visibility(
            visible: widget.formBloc.scheduleFields.isNotEmpty,
            child: ScheduleFields(widget.formBloc),
          ),
        ),
        PageNavigator(
          widget.controller,
          isFinalPage: true,
          onSubmit: widget.formBloc.submit,
        ),
      ],
    );
  }
}

class ScheduleFields extends StatefulWidget {
  const ScheduleFields(
    this.formBloc, {
    Key key,
  }) : super(key: key);

  final AddScheduleFormBloc formBloc;

  @override
  _ScheduleFieldsState createState() => _ScheduleFieldsState();
}

class _ScheduleFieldsState extends State<ScheduleFields> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.formBloc.scheduleFields.length,
      itemBuilder: (BuildContext context, int i) {
        final Map<String, FieldBloc> currentMap =
            widget.formBloc.scheduleFields[i];
        return ScheduleField(
          dayFieldBloc: currentMap['dayFieldBloc'] as SelectFieldBloc<String>,
          startTimeBloc:
              currentMap['startTimeBloc'] as InputFieldBloc<TimeOfDay>,
          endTimeBloc: currentMap['endTimeBloc'] as InputFieldBloc<TimeOfDay>,
          onRemove: () {
            widget.formBloc.scheduleFields.removeAt(i);
            setState(() {});
          },
        );
      },
    );
  }
}
