import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_life/blocs/add_assignment/add_assignment_bloc.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Assignment",
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

  List<Map<String, dynamic>> _subjectsMap;

  @override
  void initState() {
    super.initState();
    _setSubjectsMap();
  }

  @override
  void dispose() {
    // dispose of all FocusNode's
    nodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void _setSubjectsMap() async {
    List<Subject> subjects = await RepositoryServiceSubject.getAllSubjects();
    List<Map<String, dynamic>> temp = [];
    for (int i = 0; i < subjects.length; i++) {
      temp.add(subjects[i].toJson());
    }
    setState(() {
      _subjectsMap = temp;
    });
  }

  void changeFieldFocus(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  @override
  Widget build(BuildContext context) {
    if (_subjectsMap == null) return Center(child: CircularProgressIndicator());
    final format = DateFormat("yyyy-MM-dd");

    return BlocProvider<AddAssignmentFormBloc>(
      builder: (context) => AddAssignmentFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AddAssignmentFormBloc>(context);

          return WillPopScope(
            onWillPop: () => formBloc.requestPop(context),
            child: FormBlocListener<AddAssignmentFormBloc, String, dynamic>(
              onSuccess: (context, state) {
                Navigator.pushReplacementNamed(context, '/assignments');
              },
              onFailure: (context, state) {
                print(state.failureResponse);
              },
              onLoadFailed: (context, state) {
                print("load failed");
                print(state.canSubmit);
              },
              onLoading: (context, state) {
                print("loading");
              },
              child: ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10),
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.nameField,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BlocBuilder(
                      bloc: formBloc.dueDateField,
                      builder: (context, state) {
                        return DateTimeField(
                          format: format,
                          focusNode: dueDateFocus,
                          onFieldSubmitted: (value) =>
                              formBloc.dueDateField.updateValue(value),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: "Due date (${format.pattern})",
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          initialValue: formBloc.dueDateField.value,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(
                                Duration(days: 1),
                              ),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime.now().add(
                                Duration(days: 365 * 5),
                              ),
                            );
                          },
                          onChanged: (value) =>
                              formBloc.dueDateField.updateValue(value),
                        );
                      },
                    ),
                  ),
                  DropdownFieldBlocBuilder(
                    selectFieldBloc: formBloc.subjectField,
                    millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                    focusNode: subjectFocus,
                    nextFocusNode: detailsFocus,
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
                  SizedBox(
                    height: 100,
                    child: TextFieldBlocBuilder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      textFieldBloc: formBloc.detailsField,
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
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: OutlineButton(
                      highlightedBorderColor: Theme.of(context)
                          .inputDecorationTheme
                          .border
                          .borderSide
                          .color,
                      onPressed: formBloc.submit,
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
