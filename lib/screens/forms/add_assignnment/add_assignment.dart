import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:school_life/screens/forms/widgets/custom_form_field.dart';
import 'package:school_life/screens/forms/widgets/dialog_on_pop.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/assignment.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

final formState = GlobalKey<_AddAssignmentFormState>();

class AddAssignmentPage extends StatefulWidget {
  static final addAssignmentFormKey = GlobalKey<FormBuilderState>();

  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _assignmentNameTextCont = TextEditingController();
  final _dueDateTextCont = TextEditingController();
  final _detailsTextCont = TextEditingController();

  @override
  void dispose() {
    _assignmentNameTextCont.dispose();
    _dueDateTextCont.dispose();
    _detailsTextCont.dispose();
    super.dispose();
  }

  void _addAssignment(BuildContext context) async {
    // get the number of subjects, returns # of subjects + 1
    int _nextID = await RepositoryServiceAssignment.assignmentsCount();
    // trimmed assignment name
    String _assignmentName = _assignmentNameTextCont.text.trim();
    // trimmed due date
    DateTime _dueDate = DateTime.parse(_dueDateTextCont.text.trim());
    // trimmed details text
    String _detailsText = _detailsTextCont.text.trim();
    _detailsText ??= "";
    //! ALWAYS FALSE
    bool isDeleted = false;
    // create new assignment based on text from form
    Assignment newAssignment = Assignment(
      _nextID,
      _assignmentName,
      _dueDate,
      selectedSubjectID,
      _detailsText,
      isDeleted,
    );
    await RepositoryServiceAssignment.addAssignment(newAssignment);
    Navigator.pushReplacementNamed(context, '/assignments');
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String text1 = _assignmentNameTextCont.text.trim();
    String text2 = _dueDateTextCont.text.trim();
    String text3 = _detailsTextCont.text.trim();
    // if they're all empty, return true
    if (text1.isEmpty &&
        text2.isEmpty &&
        selectedSubjectID == null &&
        text3.isEmpty) return true;
    // otherwise, return false
    return false;
  }

  Future<bool> _requestPop(BuildContext context) {
    // if the text fields are empty, user can exit
    if (_fieldsAreEmpty()) return Future.value(true);
    // otherwise, show a popup dialog
    DialogOnPop.showPopupDialog(context);
    // default, return false
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _requestPop(context),
      child: CustomScaffold(
        appBarTitle: "Add Assignment",
        appBarLeading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        fab: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (AddAssignmentPage.addAssignmentFormKey.currentState
                .saveAndValidate()) _addAssignment(context);
            return null;
          },
        ),
        scaffoldBody: AddAssignmentForm(
          globalKey: AddAssignmentPage.addAssignmentFormKey,
          assignNameCont: _assignmentNameTextCont,
          dueDateFieldCont: _dueDateTextCont,
          detailsFieldCont: _detailsTextCont,
        ),
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

int selectedSubjectID;

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  final DateTime _currentDate = DateTime.now();
  final FocusNode subjectFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();
  final FocusNode dueDateFocus = FocusNode();
  final FocusNode assignmentFocus = FocusNode();

  List<Map<String, dynamic>> _subjectsMap;

  @override
  void initState() {
    super.initState();
    _setSubjectsMap();
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
    if (_currentDate == null || _subjectsMap == null)
      return Center(child: CircularProgressIndicator());
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
          selectedSubjectID = value;
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
      padding: const EdgeInsets.only(bottom: 10),
      primary: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            FormBuilder(
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
            SizedBox(height: 10),
            detailsField,
          ],
        ),
      ),
    );
  }
}
