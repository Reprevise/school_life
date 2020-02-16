import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/forms/page_navigator.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/schedule/add_schedule/widgets/schedule_field.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({
    Key key,
    this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final PageController _controller = PageController();

  AddScheduleFormBloc _formBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.subject != null) {
        _formBloc.subjectField.updateValue(
          <String, dynamic>{
            'display': widget.subject.name,
            'value': widget.subject.id,
          },
        );
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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
      body: FormBlocHelper<AddScheduleFormBloc>(
        create: (_) => AddScheduleFormBloc(),
        onSuccess: (_, __) {
          Router.navigator.pushNamed(Router.schedule);
        },
        builder: (context, state) {
          if (state is FormBlocLoading || state is FormBlocSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            _formBloc = BlocProvider.of<AddScheduleFormBloc>(context);
            return WillPopScope(
              onWillPop: () => _formBloc.canPop(context),
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  _FirstPage(_formBloc, _controller),
                  _SecondPage(_formBloc, _controller),
                ],
              ),
            );
          }
        },
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
    final cWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'What subject do you want to create a schedule for?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: DropdownFieldBlocBuilder<Map<String, dynamic>>(
                selectFieldBloc: formBloc.subjectField,
                millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                itemBuilder: (context, value) => value['name'] as String,
                showEmptyItem: false,
                decoration: InputDecoration(
                  labelText: 'Subject*',
                  prefixIcon: Icon(
                    Icons.subject,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
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
    final cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            'Let\'s setup the schedule',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline3,
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
    return Column(
      children: <Widget>[
        const FormRequired(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.formBloc.scheduleFields.length,
            itemBuilder: (context, i) {
              final currentMap = widget.formBloc.scheduleFields[i];
              return ScheduleField(
                dayFieldBloc:
                    currentMap['dayFieldBloc'] as SelectFieldBloc<String>,
                startTimeBloc:
                    currentMap['startTimeBloc'] as InputFieldBloc<TimeOfDay>,
                endTimeBloc:
                    currentMap['endTimeBloc'] as InputFieldBloc<TimeOfDay>,
                onRemove: () {
                  widget.formBloc.scheduleFields.removeAt(i);
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
