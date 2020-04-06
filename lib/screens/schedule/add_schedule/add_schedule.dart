import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:school_life/bloc/add_schedule_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/forms/field_bloc_list_builder/field_bloc_list_builder.dart';
import 'package:school_life/components/forms/page_navigator.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/components/index.dart';
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
          Router.navigator.pushNamed(Routes.schedule);
        },
        onSubmitting: (_, __) {
          return const Center(child: CircularProgressIndicator());
        },
        onLoading: (_, __) {
          return const Center(child: CircularProgressIndicator());
        },
        builder: (context, state) {
          _formBloc = context.bloc<AddScheduleFormBloc>();
          return WillPopScope(
            onWillPop: () => _formBloc.canPop(context),
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _FirstPage(_formBloc, _controller),
                _SecondPage(
                  form: _formBloc,
                  controller: _controller,
                  onFieldRemove: (indx) {
                    _formBloc.removeScheduleField(indx);
                  },
                  onSubmit: _formBloc.submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage(this.form, this.controller);

  final AddScheduleFormBloc form;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        SizedBox(
          width: cWidth,
          child: Text(
            'What subject do you want to create a schedule for?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Expanded(
          child: Center(
            child: DropdownFieldBlocBuilder<Map<String, dynamic>>(
              selectFieldBloc: form.subjectField,
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
        PageNavigator(
          controller,
          isFirstPage: true,
        ),
      ],
    );
  }
}

class _SecondPage extends StatefulWidget {
  const _SecondPage({
    @required this.form,
    @required this.controller,
    @required this.onSubmit,
    @required this.onFieldRemove,
  });

  final AddScheduleFormBloc form;
  final PageController controller;
  final VoidCallback onSubmit;
  final Function(int) onFieldRemove;

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
        SizedBox(
          width: cWidth,
          child: Text(
            'Let\'s setup the schedule',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Expanded(
          child: ScheduleFields(
            widget.form,
            onRemove: (index) {
              widget.onFieldRemove(index);
              setState(() {});
            },
          ),
        ),
        PageNavigator(
          widget.controller,
          isFinalPage: true,
          onSubmit: widget.onSubmit,
        ),
      ],
    );
  }
}

class ScheduleFields extends StatelessWidget {
  const ScheduleFields(
    this.form, {
    @required this.onRemove,
  });

  final AddScheduleFormBloc form;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const FormRequired(),
        Expanded(
          child: FieldBlocListBuilder<DayScheduleField>(
            fieldBlocList: form.schedule,
            itemBuilder: (context, list, i) {
              final group = list.value[i];
              return ScheduleField(
                dayFieldBloc: group.day,
                startTimeBloc: group.startTime,
                endTimeBloc: group.endTime,
                onRemove: () => onRemove(i),
              );
            },
          ),
        ),
      ],
    );
  }
}
