import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:school_life/blocs/add_subject/add_subject_bloc.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class AddSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Add Subject",
      appBarLeading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.maybePop(context),
      ),
      scaffoldBody: AddSubjectForm(),
    );
  }
}

class AddSubjectForm extends StatefulWidget {
  @override
  _AddSubjectFormState createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  final FocusNode subjectFocus = FocusNode();
  final FocusNode roomTextFocus = FocusNode();
  final FocusNode buildingFocus = FocusNode();
  final FocusNode teacherFocus = FocusNode();
  List<FocusNode> get nodes =>
      [subjectFocus, roomTextFocus, buildingFocus, teacherFocus];

  @override
  void dispose() {
    // dispose of all FocusNode's
    nodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSubjectFormBloc>(
      builder: (context) => AddSubjectFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AddSubjectFormBloc>(context);

          return WillPopScope(
            onWillPop: () => formBloc.canPop(context),
            child: FormBlocListener<AddSubjectFormBloc, String, String>(
              onSuccess: (context, state) {
                Navigator.of(context).pushReplacementNamed('/subjects');
              },
              child: ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10),
                children: <Widget>[
                  TextFieldBlocBuilder(
                    autofocus: true,
                    textFieldBloc: formBloc.nameField,
                    focusNode: subjectFocus,
                    nextFocusNode: roomTextFocus,
                    textInputAction: TextInputAction.next,
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
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.roomField,
                    focusNode: roomTextFocus,
                    nextFocusNode: buildingFocus,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Room",
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.buildingField,
                    focusNode: buildingFocus,
                    nextFocusNode: teacherFocus,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Building",
                      prefixIcon: Icon(
                        Icons.business,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.teacherField,
                    focusNode: teacherFocus,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Teacher",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  BlocBuilder(
                    bloc: formBloc.colorField,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: RaisedButton(
                          elevation: 3.0,
                          color: formBloc?.currentColor,
                          textColor: useWhiteForeground(formBloc?.currentColor)
                              ? Color(0xffffffff)
                              : Color(0xff000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                              right: Radius.circular(50),
                            ),
                          ),
                          child: Text("Change color"),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Select a color"),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    availableColors: formBloc.availableColors,
                                    pickerColor: formBloc.currentColor,
                                    onColorChanged: (Color color) {
                                      formBloc.colorField.updateValue(color);
                                      formBloc.currentColor = color;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
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
