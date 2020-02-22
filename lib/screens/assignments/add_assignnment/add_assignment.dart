import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/add_assignment_bloc.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/forms/required/form_required.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Assignment'),
      body: _AddAssignmentForm(),
    );
  }
}

class _AddAssignmentForm extends StatefulWidget {
  @override
  _AddAssignmentFormState createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<_AddAssignmentForm> {
  AddAssignmentFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-dd');

    return FormBlocHelper<AddAssignmentFormBloc>(
      create: (_) => AddAssignmentFormBloc(),
      onSuccess: (_, __) {
        Router.navigator.pushNamed(Router.assignments);
      },
      builder: (context, state) {
        if (state is FormBlocLoading || state is FormBlocSubmitting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          _formBloc = context.bloc<AddAssignmentFormBloc>();
          return WillPopScope(
            onWillPop: () => _formBloc.canPop(context),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 8),
              children: <Widget>[
                const FormRequired(),
                TextFieldBlocBuilder(
                  textFieldBloc: _formBloc.nameField,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<InputFieldBloc<DateTime>,
                      InputFieldBlocState<DateTime>>(
                    bloc: _formBloc.dueDateField,
                    builder: (context, state) {
                      return DateField(
                        format: format,
                        errorText: state.error,
                        isRequired: true,
                        labelText: 'Due date',
                        selectedDate: DateTime.now().onlyDate,
                        onDateChanged: _formBloc.dueDateField.updateValue,
                      );
                    },
                  ),
                ),
                DropdownFieldBlocBuilder<Map<String, dynamic>>(
                  selectFieldBloc: _formBloc.subjectField,
                  itemBuilder: (context, value) => value['name'] as String,
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
                TextFieldBlocBuilder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textFieldBloc: _formBloc.detailsField,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: OutlineButton(
                          padding: EdgeInsets.zero,
                          borderSide: Theme.of(context)
                              .inputDecorationTheme
                              .border
                              .borderSide,
                          textColor:
                              Theme.of(context).textTheme.bodyText2.color,
                          onPressed: _formBloc.submit,
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
