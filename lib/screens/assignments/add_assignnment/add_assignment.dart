import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/add_assignment_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BackButton(),
                const ScreenHeader('Create Assignment'),
              ],
            ),
            FormBlocHelper(
              create: (_) => AddAssignmentFormBloc(),
              onSuccess: (_, __) {
                ExtendedNavigator.rootNavigator.pushNamed(Routes.assignments);
              },
              onSubmitting: (_, __) {
                return const Center(child: CircularProgressIndicator());
              },
              onLoading: (_, __) {
                return const Center(child: CircularProgressIndicator());
              },
              builder: (context, snapshot) {
                final formBloc = context.bloc<AddAssignmentFormBloc>();

                return WillPopScope(
                  onWillPop: () => formBloc.canPop(context),
                  child: _AddAssignmentForm(formBloc),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAssignmentForm extends StatefulWidget {
  _AddAssignmentForm(this.formBloc);

  final AddAssignmentFormBloc formBloc;

  @override
  _AddAssignmentFormState createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<_AddAssignmentForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-dd');

    return ListView(
      padding: const EdgeInsets.only(bottom: 8),
      shrinkWrap: true,
      children: <Widget>[
        const FormRequired(),
        TextFieldBlocBuilder(
          textFieldBloc: widget.formBloc.nameField,
          autofocus: true,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Assignment Name*',
            prefixIcon: Icon(
              Icons.assignment,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        DateTimeFieldBlocBuilder(
          dateTimeFieldBloc: widget.formBloc.dueDateField,
          format: format,
          initialDate: DateTime.now().onlyDate,
          firstDate: DateTime.now().onlyDate,
          lastDate: DateTime.now().addYears(1),
          decoration: InputDecoration(
            labelText: 'Due date',
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        DropdownFieldBlocBuilder<Map<String, dynamic>>(
          selectFieldBloc: widget.formBloc.subjectField,
          itemBuilder: (_, value) => value['name'] as String,
          showEmptyItem: false,
          decoration: InputDecoration(
            labelText: 'Subject*',
            prefixIcon: Icon(
              Icons.school,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          child: TextFieldBlocBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            textFieldBloc: widget.formBloc.detailsField,
            expands: true,
            minLines: null,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              labelText: 'Details',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: OutlineButton(
                  padding: EdgeInsets.zero,
                  borderSide:
                      Theme.of(context).inputDecorationTheme.border.borderSide,
                  textColor: Theme.of(context).textTheme.bodyText2.color,
                  onPressed: widget.formBloc.submit,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
