import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/date_time_field.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/util/date_utils.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Add Assignment",
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      drawer: CustomDrawer(),
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
    final format = DateFormat("yyyy-MM-dd");

    return BlocProvider<AddAssignmentFormBloc>(
      create: (context) => AddAssignmentFormBloc(),
      child: Builder(
        builder: (context) {
          _formBloc = BlocProvider.of<AddAssignmentFormBloc>(context);

          return WillPopScope(
            onWillPop: () => _formBloc.requestPop(context),
            child: FormBlocListener<AddAssignmentFormBloc, String, dynamic>(
              onSuccess: (context, state) {
                Navigator.pushReplacementNamed(context, '/assignments');
              },
              child: BlocBuilder<AddAssignmentFormBloc, FormBlocState>(
                builder: (context, state) {
                  if (state is FormBlocLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is FormBlocLoadFailed) {
                    return Center(child: Text("Uh oh! Try again later."));
                  } else {
                    return SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
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
                              labelText: "Assignment Name",
                              prefixIcon: Icon(
                                Icons.assignment,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BlocBuilder(
                              bloc: _formBloc.dueDateField,
                              builder: (context, FieldBlocState state) {
                                return DateField(
                                  format: format,
                                  errorText: state.error,
                                  labelText: "Due date",
                                  selectedDate: DateTime.now().todaysDate,
                                  onDateChanged: (value) {
                                    _formBloc.dueDateField.updateValue(value);
                                  },
                                );
                              },
                            ),
                          ),
                          DropdownFieldBlocBuilder(
                            selectFieldBloc: _formBloc.subjectField,
                            itemBuilder: (context, value) => value['name'],
                            showEmptyItem: false,
                            decoration: InputDecoration(
                              labelText: "Subject",
                              prefixIcon: Icon(
                                Icons.school,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
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
                                labelText: "Details",
                                prefixIcon: Icon(
                                  Icons.subject,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
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
                              child: const Text("Submit"),
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
