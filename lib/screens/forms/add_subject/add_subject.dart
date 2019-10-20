import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:school_life/screens/forms/widgets/custom_form_field.dart';
import 'package:school_life/screens/forms/widgets/dialog_on_pop.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';

Color currentColor = Colors.yellow;

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final _subjectController = TextEditingController();
  final _roomTextController = TextEditingController();
  final _buildingTextController = TextEditingController();
  final _teacherTextController = TextEditingController();
  final _addSubjectFormKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    // dispose all of the text controllers
    _subjectController.dispose();
    _roomTextController.dispose();
    _buildingTextController.dispose();
    _teacherTextController.dispose();
    super.dispose();
  }

  void addSubject() async {
    // get the number of subjects, returns # of subjects + 1
    int nextID = await RepositoryServiceSubject.subjectsCount();
    // trimmed subject name
    String subjectName = _subjectController.text.trim();
    // get room field text
    String roomText = _roomTextController.text.trim();
    // get building field text
    String building = _buildingTextController.text.trim();
    // get teacher field text
    String teacher = _teacherTextController.text.trim();
    // get color and convert to string
    String color = currentColor.toString();
    //! ALWAYS FALSE
    bool isDeleted = false;
    // create new subject based on text from form
    Subject newSubject = Subject(
      nextID,
      subjectName,
      roomText,
      building,
      teacher,
      color,
      isDeleted,
    );
    RepositoryServiceSubject.addSubject(newSubject).then((id) {
      // if successfully adds subject, go back to subjects back
      Navigator.pushReplacementNamed(context, '/subjects');
    }).catchError((error) {
      // if an error occured
      print("an error occured"); // state an error occured before printing error
      print(error); // print the error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Subject',
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (_addSubjectFormKey.currentState.saveAndValidate()) {
            addSubject();
          }
          return null;
        },
      ),
      body: AddSubjectForm(
        subjectCont: _subjectController,
        roomTextCont: _roomTextController,
        buildingCont: _buildingTextController,
        teacherCont: _teacherTextController,
        globalKey: _addSubjectFormKey,
      ),
    );
  }
}

class AddSubjectForm extends StatefulWidget {
  final TextEditingController subjectCont;
  final TextEditingController roomTextCont;
  final TextEditingController buildingCont;
  final TextEditingController teacherCont;
  final GlobalKey<FormBuilderState> globalKey;

  AddSubjectForm(
      {Key key,
      @required this.globalKey,
      @required this.subjectCont,
      @required this.roomTextCont,
      @required this.buildingCont,
      @required this.teacherCont})
      : super(key: key);

  @override
  _AddSubjectFormState createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  final FocusNode subjectFocus = FocusNode();
  final FocusNode roomTextFocus = FocusNode();
  final FocusNode buildingFocus = FocusNode();
  final FocusNode teacherFocus = FocusNode();
  List<String> subjectNames = [];
  List<String> subjectColors = [];

  @override
  void initState() {
    super.initState();
    _getSubjectNamesAndColors();
  }

  void _getSubjectNamesAndColors() {
    RepositoryServiceSubject.getAllSubjects().then((subjects) {
      if (subjects.isEmpty) return;
      List<String> nameTemp = [];
      List<String> colorTemp = [];
      subjects.forEach((subject) {
        nameTemp.add(subject.name.toLowerCase());
        colorTemp.add(subject.color);
      });
      setState(() {
        subjectNames = nameTemp;
        subjectColors = colorTemp;
      });
    });
  }

  @override
  void dispose() {
    // dispose of all FocusNode's
    subjectFocus.dispose();
    roomTextFocus.dispose();
    buildingFocus.dispose();
    teacherFocus.dispose();
    super.dispose();
  }

  bool _fieldsAreEmpty() {
    // get all controllers' text and trim them
    String text1 = widget.subjectCont.text.trim();
    String text2 = widget.roomTextCont.text.trim();
    String text3 = widget.buildingCont.text.trim();
    String text4 = widget.teacherCont.text.trim();
    // if they're all empty, return true
    if (text1.isEmpty && text2.isEmpty && text3.isEmpty && text4.isEmpty)
      return true;
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

  changeFieldFocus(BuildContext context, FocusNode current, FocusNode next) {
    // unfocus current node
    current.unfocus();
    // request to focus next node
    FocusScope.of(context).requestFocus(next);
  }

  _sameColorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Same color exists already!"),
          content: Text("You have already picked that color for another subject! Please change it."),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "Ok",
                style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle.color,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget subjectNameFormField = CustomFormField(
      attribute: 'subject-name',
      focusNode: subjectFocus,
      autofocus: true,
      hintText: "Subject",
      prefixIcon: Icons.subject,
      initialValue: "",
      controller: widget.subjectCont,
      onFieldSubmitted: (_) =>
          changeFieldFocus(context, subjectFocus, roomTextFocus),
      validators: [
        FormBuilderValidators.required(
            errorText: "Please enter the subject name"),
        FormBuilderValidators.maxLength(22,
            errorText: "The subject can't be longer than 22 characters"),
        (value) {
          if (subjectNames.contains(value.trim().toLowerCase()))
            return 'That subject name is taken';
          return null;
        }
      ],
    );
    Widget roomField = CustomFormField(
      attribute: 'room',
      initialValue: "",
      focusNode: roomTextFocus,
      controller: widget.roomTextCont,
      textCapitalization: TextCapitalization.none,
      hintText: "Room",
      validators: [
        FormBuilderValidators.required(errorText: "Please enter the room I.D."),
        FormBuilderValidators.maxLength(15,
            errorText: "The room I.D. can't be longer than 15 characters"),
      ],
      prefixIcon: Icons.location_on,
      onFieldSubmitted: (_) =>
          changeFieldFocus(context, roomTextFocus, buildingFocus),
    );
    Widget buildingFormField = CustomFormField(
      attribute: 'building',
      initialValue: "",
      focusNode: buildingFocus,
      controller: widget.buildingCont,
      hintText: "Building",
      prefixIcon: Icons.business,
      validators: [
        FormBuilderValidators.maxLength(20,
            errorText: "The building field can't be longer than 25 characters"),
      ],
      onFieldSubmitted: (_) =>
          changeFieldFocus(context, buildingFocus, teacherFocus),
    );
    Widget teacherFormField = CustomFormField(
      attribute: 'teacher',
      focusNode: teacherFocus,
      initialValue: "",
      controller: widget.teacherCont,
      textInputAction: TextInputAction.done,
      hintText: "Teacher",
      prefixIcon: Icons.person,
      validators: [
        FormBuilderValidators.required(
            errorText: "Please enter the teacher's name"),
        FormBuilderValidators.maxLength(30,
            errorText: "The teacher's name can't be longer than 30 characters"),
      ],
      onFieldSubmitted: (_) => teacherFocus.unfocus(),
    );
    Widget selectColorBtn = RaisedButton(
      elevation: 3.0,
      color: currentColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select a color"),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: currentColor,
                  onColorChanged: (Color color) {
                    Navigator.pop(context);
                    if (subjectColors.contains(color.toString()))
                      setState(() {
                        currentColor = color;
                      });
                  },
                ),
              ),
            );
          },
        );
      },
      textColor: useWhiteForeground(currentColor)
          ? Color(0xffffffff)
          : Color(0xff000000),
      child: Text("Change color"),
    );
    return FormBuilder(
      key: widget.globalKey,
      onWillPop: _requestPop,
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            subjectNameFormField,
            SizedBox(height: 10),
            roomField,
            SizedBox(height: 10),
            buildingFormField,
            SizedBox(height: 10),
            teacherFormField,
            SizedBox(height: 10),
            selectColorBtn,
          ],
        ),
      ),
    );
  }
}
