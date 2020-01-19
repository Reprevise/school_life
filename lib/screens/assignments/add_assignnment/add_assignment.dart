import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Assignment'),
      body: AddAssignmentForm(),
    );
  }
}

class AddAssignmentForm extends StatefulWidget {
  @override
  _AddAssignmentFormState createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  AddAssignmentFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('yyyy-MM-dd');

    return BlocProvider<AddAssignmentFormBloc>(
      create: (BuildContext context) => AddAssignmentFormBloc(),
      child: Builder(
        builder: (BuildContext context) {
          _formBloc = BlocProvider.of<AddAssignmentFormBloc>(context);

          return WillPopScope(
            onWillPop: () => _formBloc.requestPop(context),
            child: FormBlocListener<AddAssignmentFormBloc, String, dynamic>(
              onSuccess: (BuildContext context, dynamic state) {
                Router.navigator.pushReplacementNamed(Router.assignments);
              },
              child: BlocBuilder<AddAssignmentFormBloc,
                  FormBlocState<String, dynamic>>(
                builder: (BuildContext context,
                    FormBlocState<String, dynamic> state) {
                  if (state is FormBlocLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FormBlocLoadFailed) {
                    return const Center(child: Text('Uh oh! Try again later.'));
                  } else {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFieldBlocBuilder(
                            textFieldBloc: _formBloc.nameField,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Assignment Name',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BlocBuilder<InputFieldBloc<DateTime>,
                                InputFieldBlocState<DateTime>>(
                              bloc: _formBloc.dueDateField,
                              builder: (BuildContext context,
                                  InputFieldBlocState<DateTime> state) {
                                return DateField(
                                  format: format,
                                  errorText: state.error,
                                  labelText: 'Due date',
                                  selectedDate: DateTime.now().todaysDate,
                                  onDateChanged: (DateTime value) {
                                    _formBloc.dueDateField.updateValue(value);
                                  },
                                );
                              },
                            ),
                          ),
                          DropdownFieldBlocBuilder<Map<String, dynamic>>(
                            selectFieldBloc: _formBloc.subjectField,
                            itemBuilder: (BuildContext context,
                                    Map<String, dynamic> value) =>
                                value['name'] as String,
                            showEmptyItem: false,
                            decoration: InputDecoration(
                              labelText: 'Subject',
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
                            height: 100,
                            child: TextFieldBlocBuilder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: OutlineButton(
                              padding: EdgeInsets.zero,
                              borderSide: Theme.of(context)
                                  .inputDecorationTheme
                                  .border
                                  .borderSide,
                              textColor:
                                  Theme.of(context).textTheme.body1.color,
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
            ),
          );
        },
      ),
    );
  }
}
