import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:school_life/screens/forms/widgets/custom_form_field.dart';
import 'package:school_life/screens/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';

final formState = GlobalKey<_AddAssignmentFormState>();

class AddAssignmentPage extends StatefulWidget {
  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _assignmentNameTextCont = TextEditingController();
  final _dueDateTextCont = TextEditingController();
  final _detailsTextCont = TextEditingController();
  final _addAssignmentFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Assignment",
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            DialogOnPop().showPopupDialog(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (_addAssignmentFormKey.currentState.saveAndValidate()) {
            // addAssignment();
          }
          return null;
        },
      ),
      body: AddAssignmentForm(
        globalKey: _addAssignmentFormKey,
        assignNameCont: _assignmentNameTextCont,
        dueDateFieldCont: _dueDateTextCont,
        detailsFieldCont: _detailsTextCont,
      ),
    );
  }
}

class AddAssignmentForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> globalKey;
  final TextEditingController assignNameCont;
  final TextEditingController dueDateFieldCont;
  final TextEditingController detailsFieldCont;

  AddAssignmentForm(
      {Key key,
      @required this.globalKey,
      this.assignNameCont,
      @required this.dueDateFieldCont,
      @required this.detailsFieldCont})
      : super(key: key);

  @override
  _AddAssignmentFormState createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  DateTime _currentDate;
  List<Map<String, dynamic>> _subjectsMap;
  int _selectedSubjectID;
  int get selectedSubjectID => _selectedSubjectID;

  final FocusNode assignmentFocus = FocusNode();
  final FocusNode dueDateFocus = FocusNode();
  final FocusNode subjectFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setCurrentDate();
    _setSubjectsMap();
  }

  void _setCurrentDate() async {
    NTP.now().then((date) {
      setState(() {
        _currentDate = date;
      });
    });
  }

  void _setSubjectsMap() {
    RepositoryServiceSubject.getAllSubjects().then((subjects) {
      List<Map<String, dynamic>> temp = [];
      for (int i = 0; i < subjects.length; i++) {
        temp.add(subjects[i].toJson());
      }
      setState(() {
        _subjectsMap = temp;
      });
    });
  }

  void changeFieldFocus(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String text1 = widget.assignNameCont.text.trim();
    String text2 = widget.dueDateFieldCont.text.trim();
    String text3 = widget.detailsFieldCont.text.trim();
    // if they're all empty, return true
    if (text1.isEmpty &&
        text2.isEmpty &&
        _selectedSubjectID == null &&
        text3.isEmpty) return true;
    // otherwise, return false
    return false;
  }

  Future<bool> _requestPop() {
    // if the text fields are empty, user can exit
    if (_fieldsAreEmpty()) return Future.value(true);
    // otherwise, show a popup dialog
    DialogOnPop().showPopupDialog(context);
    // default, return false
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentDate == null) return Center(child: CircularProgressIndicator());
    if (_subjectsMap == null) return Center(child: CircularProgressIndicator());
    final format = DateFormat("yyyy-MM-dd");

    Widget assignmentNameField = CustomFormField(
      attribute: 'assignment-name',
      autofocus: true,
      focusNode: assignmentFocus,
      textCapitalization: TextCapitalization.words,
      controller: widget.assignNameCont,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => assignmentFocus.unfocus(),
      hintText: "Assignment Name",
      prefixIcon: Icons.assignment,
      validators: [
        FormBuilderValidators.required(
            errorText: "Please enter the assignment name")
      ],
    );
    Widget dueDateSelector = FormBuilderDateTimePicker(
      attribute: 'due-date',
      inputType: InputType.date,
      format: format,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "Due date (${format.pattern})",
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
      firstDate: _currentDate.subtract(Duration(days: 1)),
      initialDate: _currentDate,
      lastDate: _currentDate.add(Duration(days: 3650)),
      controller: widget.dueDateFieldCont,
      onFieldSubmitted: (_) => dueDateFocus.unfocus(),
      focusNode: dueDateFocus,
    );
    Widget subjectField = FormBuilderDropdown(
      attribute: 'subject',
      hint: Text("Subject"),
      validators: [
        FormBuilderValidators.required(errorText: "You must select a subject")
      ],
      onChanged: (value) {
        setState(() {
          _selectedSubjectID = value;
        });
      },
      items: _subjectsMap.map((subject) {
        return DropdownMenuItem(
          value: subject['value'],
          child: Text(subject['display']),
        );
      }).toList(),
    );
    Widget detailsField = SizedBox(
      height: 100,
      child: TextField(
        keyboardType: TextInputType.multiline,
        focusNode: detailsFocus,
        controller: widget.detailsFieldCont,
        expands: true,
        minLines: null,
        maxLines: null,
        onSubmitted: (_) => detailsFocus.unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Details",
          prefixIcon: Icon(Icons.subject,
              color: Theme.of(context).primaryIconTheme.color),
        ),
        textAlignVertical: TextAlignVertical.top,
      ),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 10),
      primary: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            FormBuilder(
              onWillPop: _requestPop,
              key: widget.globalKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  assignmentNameField,
                  SizedBox(height: 10),
                  dueDateSelector,
                  SizedBox(height: 10),
                  subjectField,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: detailsField,
            ),
          ],
        ),
      ),
    );
  }
}
