import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:school_life/bloc/add_subject_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/subjects/add_subject/widgets/color_picker.dart';

class AddSubjectPage extends StatelessWidget {
  void _goToSchedulePage(AddSubjectFormBloc bloc) {
    Router.navigator.popAndPushNamed(Routes.addSchedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BackButton(),
                const ScreenHeader('Create Subject'),
              ],
            ),
            Expanded(
              child: FormBlocHelper<AddSubjectFormBloc>(
                create: (_) => AddSubjectFormBloc(),
                onSubmitting: (_, __) {
                  return const Center(child: CircularProgressIndicator());
                },
                onLoading: (_, __) {
                  return const Center(child: CircularProgressIndicator());
                },
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
                              Router.navigator.popAndPushNamed(Routes.subjects);
                            },
                            child: const Text('NO'),
                          ),
                          FlatButton(
                            onPressed: () => _goToSchedulePage(
                                context.bloc<AddSubjectFormBloc>()),
                            child: const Text('YES'),
                          ),
                        ],
                      );
                    },
                  );
                },
                builder: (context, _) {
                  final formBloc = context.bloc<AddSubjectFormBloc>();

                  return WillPopScope(
                    onWillPop: () => formBloc.canPop(context),
                    child: AddSubjectFormFields(formBloc),
                  );
                },
              ),
            ),
          ],
        ),
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
    final theme = Theme.of(context);
    final iconColor = theme.primaryIconTheme.color;

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
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
                  prefixIcon: Icon(Icons.subject, color: iconColor),
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
                  prefixIcon: Icon(Icons.location_on, color: iconColor),
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
                  prefixIcon: Icon(Icons.business, color: iconColor),
                  focusedErrorBorder: errorBorder,
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.teacherField,
                focusNode: _teacherFocus,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Teacher*',
                  prefixIcon: Icon(Icons.person, color: iconColor),
                  focusedErrorBorder: errorBorder,
                ),
              ),
              SubjectColorPicker(widget.formBloc),
            ],
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: OutlineButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 16,
            ),
            borderSide: theme.inputDecorationTheme.border.borderSide,
            textColor: theme.textTheme.subtitle.color,
            onPressed: widget.formBloc.submit,
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
