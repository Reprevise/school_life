import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/blocs/blocs.dart';
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
  final FocusNode subjectFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();
  final FocusNode dueDateFocus = FocusNode();
  final FocusNode assignmentFocus = FocusNode();

  List<FocusNode> get nodes =>
      [subjectFocus, detailsFocus, dueDateFocus, assignmentFocus];

  AddAssignmentFormBloc _formBloc;

  @override
  void dispose() {
    // dispose of all FocusNode's
    nodes.forEach((node) => node.dispose());
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return BlocProvider<AddAssignmentFormBloc>(
      builder: (context) => AddAssignmentFormBloc(),
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
                            focusNode: assignmentFocus,
                            nextFocusNode: dueDateFocus,
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
                              builder: (context, state) {
                                return DateTimeField(
                                  format: format,
                                  focusNode: dueDateFocus,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    labelText: "Due date (${format.pattern})",
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color,
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    errorText: state.error,
                                  ),
                                  initialValue: _formBloc.dueDateField.value,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now().todaysDate,
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime.now().addYears(5),
                                    );
                                  },
                                  onChanged: (value) {
                                    _formBloc.dueDateField.updateValue(value);
                                  },
                                );
                              },
                            ),
                          ),
                          DropdownFieldBlocBuilder(
                            selectFieldBloc: _formBloc.subjectField,
                            millisecondsForShowDropdownItemsWhenKeyboardIsOpen:
                                100,
                            focusNode: subjectFocus,
                            nextFocusNode: detailsFocus,
                            itemBuilder: (context, value) => value[0],
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
                          SizedBox(
                            height: 100,
                            child: TextFieldBlocBuilder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              textFieldBloc: _formBloc.detailsField,
                              focusNode: detailsFocus,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                labelText: "Details",
                                prefixIcon: Icon(
                                  Icons.details,
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