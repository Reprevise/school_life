import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/blocs.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/schedule/add_schedule/add_schedule.dart';
import 'package:school_life/screens/subjects/add_subject/widgets/color_picker.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  AddSubjectFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Add Subject'),
      body: FormBlocHelper<AddSubjectFormBloc>(
        create: (_) => AddSubjectFormBloc(),
        onSuccess: (context, _) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add a schedule?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Router.navigator.pop();
                      Router.navigator.pushNamed(Router.subjects);
                    },
                    child: const Text('NO'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Router.navigator.pop();
                      Router.navigator.push(
                        MaterialPageRoute<AddSchedulePage>(
                          builder: (_) => AddSchedulePage(
                            subject: _formBloc.subject,
                          ),
                        ),
                      );
                    },
                    child: const Text('YES'),
                  ),
                ],
              );
            },
          );
          // Router.navigator.pushNamed(Router.subjects);
        },
        builder: (context, state) {
          if (state is FormBlocLoading || state is FormBlocSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            _formBloc = BlocProvider.of<AddSubjectFormBloc>(context);
            return WillPopScope(
              onWillPop: () => _formBloc.canPop(context),
              child: AddSubjectFormFields(_formBloc),
            );
          }
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

  @override
  void dispose() {
    // dispose of all FocusNode's
    _subjectFocus.dispose();
    _roomTextFocus.dispose();
    _buildingFocus.dispose();
    _teacherFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const InputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    );
    final iconColor = Theme.of(context).primaryIconTheme.color;

    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 8),
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '* Required',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextFieldBlocBuilder(
          autofocus: true,
          textFieldBloc: widget.formBloc.nameField,
          focusNode: _subjectFocus,
          nextFocusNode: _roomTextFocus,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Subject*',
            prefixIcon: Icon(
              Icons.subject,
              color: iconColor,
            ),
            focusedErrorBorder: errorBorder,
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: widget.formBloc.roomField,
          focusNode: _roomTextFocus,
          nextFocusNode: _buildingFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Room*',
            prefixIcon: Icon(
              Icons.location_on,
              color: iconColor,
            ),
            focusedErrorBorder: errorBorder,
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
              color: iconColor,
            ),
            focusedErrorBorder: errorBorder,
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: widget.formBloc.teacherField,
          focusNode: _teacherFocus,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Teacher*',
            prefixIcon: Icon(
              Icons.person,
              color: iconColor,
            ),
            focusedErrorBorder: errorBorder,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SubjectColorPicker(widget.formBloc),
              const SizedBox(height: 8),
              Container(
                width: 150,
                child: OutlineButton(
                  padding: EdgeInsets.zero,
                  borderSide:
                      Theme.of(context).inputDecorationTheme.border.borderSide,
                  textColor: Theme.of(context).textTheme.bodyText2.color,
                  onPressed: widget.formBloc.submit,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
