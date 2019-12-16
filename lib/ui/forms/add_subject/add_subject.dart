import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/blocs/add_subject/add_subject_bloc.dart';
import 'package:school_life/components/index.dart';

class AddSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Add Subject",
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      drawer: CustomDrawer(),
      body: AddSubjectForm(),
    );
  }
}

class AddSubjectForm extends StatefulWidget {
  @override
  _AddSubjectFormState createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _roomTextFocus = FocusNode();
  final FocusNode _buildingFocus = FocusNode();
  final FocusNode _teacherFocus = FocusNode();

  List<FocusNode> get nodes =>
      [_subjectFocus, _roomTextFocus, _buildingFocus, _teacherFocus];
  AddSubjectFormBloc _formBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // dispose of all FocusNode's
    nodes.forEach((node) => node.dispose());
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSubjectFormBloc>(
      builder: (context) => AddSubjectFormBloc(),
      child: Builder(
        builder: (context) {
          _formBloc = BlocProvider.of<AddSubjectFormBloc>(context);
          return WillPopScope(
            onWillPop: () => _formBloc.canPop(context),
            child: FormBlocListener<AddSubjectFormBloc, String, String>(
              onSuccess: (context, state) {
                Navigator.of(context).pushReplacementNamed('/subjects');
              },
              child: BlocBuilder<AddSubjectFormBloc, FormBlocState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          autofocus: true,
                          textFieldBloc: _formBloc.nameField,
                          focusNode: _subjectFocus,
                          nextFocusNode: _roomTextFocus,
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
                          textFieldBloc: _formBloc.roomField,
                          focusNode: _roomTextFocus,
                          nextFocusNode: _buildingFocus,
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
                          textFieldBloc: _formBloc.buildingField,
                          focusNode: _buildingFocus,
                          nextFocusNode: _teacherFocus,
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
                          textFieldBloc: _formBloc.teacherField,
                          focusNode: _teacherFocus,
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
                          bloc: _formBloc.colorField,
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FlatButton(
                                color: _formBloc.currentColor,
                                textColor:
                                    useWhiteForeground(_formBloc?.currentColor)
                                        ? Color(0xffffffff)
                                        : Color(0xff000000),
                                child: Text("Change color"),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Select a color"),
                                      content: SingleChildScrollView(
                                        child: BlockPicker(
                                          availableColors:
                                              _formBloc.availableColors,
                                          pickerColor: _formBloc.currentColor,
                                          onColorChanged: (Color color) {
                                            _formBloc.colorField
                                                .updateValue(color);
                                            _formBloc.currentColor = color;
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
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: OutlineButton(
                            padding: EdgeInsets.zero,
                            borderSide: Theme.of(context)
                                .inputDecorationTheme
                                .border
                                .borderSide,
                            textColor: Theme.of(context).textTheme.body1.color,
                            onPressed: _formBloc.submit,
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
