import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/routing/router.gr.dart';

class AddSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Subject'),
      body: AddSubjectForm(),
    );
  }
}

class AddSubjectForm extends StatefulWidget {
  @override
  _AddSubjectFormState createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  AddSubjectFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSubjectFormBloc>(
      create: (BuildContext context) => AddSubjectFormBloc(),
      child: Builder(
        builder: (BuildContext context) {
          _formBloc = BlocProvider.of<AddSubjectFormBloc>(context);
          return WillPopScope(
            onWillPop: () => _formBloc.canPop(context),
            child: FormBlocListener<AddSubjectFormBloc, String, String>(
              onSuccess: (BuildContext context, dynamic state) {
                Router.navigator.pushReplacementNamed(Router.subjects);
              },
              child: BlocBuilder<AddSubjectFormBloc,
                  FormBlocState<String, String>>(
                builder: (BuildContext context,
                    FormBlocState<String, String> state) {
                  return AddSubjectFormFields(_formBloc);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddSubjectFormFields extends StatefulWidget {
  const AddSubjectFormFields(this.formBloc);

  final AddSubjectFormBloc formBloc;

  @override
  _AddSubjectFormFieldsState createState() => _AddSubjectFormFieldsState();
}

class _AddSubjectFormFieldsState extends State<AddSubjectFormFields> {
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _roomTextFocus = FocusNode();
  final FocusNode _buildingFocus = FocusNode();
  final FocusNode _teacherFocus = FocusNode();

  List<FocusNode> get nodes => <FocusNode>[
        _subjectFocus,
        _roomTextFocus,
        _buildingFocus,
        _teacherFocus,
      ];

  @override
  void dispose() {
    // dispose of all FocusNode's
    for (FocusNode node in nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFieldBlocBuilder(
            autofocus: true,
            textFieldBloc: widget.formBloc.nameField,
            focusNode: _subjectFocus,
            nextFocusNode: _roomTextFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Subject',
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
            textFieldBloc: widget.formBloc.roomField,
            focusNode: _roomTextFocus,
            nextFocusNode: _buildingFocus,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Room',
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
            textFieldBloc: widget.formBloc.buildingField,
            focusNode: _buildingFocus,
            nextFocusNode: _teacherFocus,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Building',
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
            textFieldBloc: widget.formBloc.teacherField,
            focusNode: _teacherFocus,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Teacher',
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
          SubjectColorPicker(widget.formBloc),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: OutlineButton(
              padding: EdgeInsets.zero,
              borderSide:
                  Theme.of(context).inputDecorationTheme.border.borderSide,
              textColor: Theme.of(context).textTheme.body1.color,
              onPressed: widget.formBloc.submit,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectColorPicker extends StatelessWidget {
  const SubjectColorPicker(this.formBloc);

  final AddSubjectFormBloc formBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputFieldBloc<Color>, dynamic>(
      bloc: formBloc.colorField,
      builder: (BuildContext context, dynamic state) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: FlatButton(
            color: formBloc.currentColor,
            textColor: Colors.black,
            child: const Text('Change color'),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select a color'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      availableColors: formBloc.availableColors,
                      pickerColor: formBloc.currentColor,
                      onColorChanged: (Color color) {
                        formBloc.colorField.updateValue(color);
                        formBloc.currentColor = color;
                        Router.navigator.pop();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
