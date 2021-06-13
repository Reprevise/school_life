import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:school_life/components/forms/form_spacer.dart';
import 'package:stacked/stacked.dart';

import '../../../components/forms/form_required.dart';
import '../../../components/screen_header/screen_header.dart';
import 'add_subject_viewmodel.dart';
import 'widgets/color_picker.dart';

class AddSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ViewModelBuilder<AddSubjectViewModel>.reactive(
        viewModelBuilder: () => AddSubjectViewModel(),
        builder: (context, model, _) {
          if (model.isBusy) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return SafeArea(
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
                  child: ReactiveForm(
                    onWillPop: model.canPop,
                    formGroup: model.form,
                    child: AddSubjectFormFields(model),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddSubjectFormFields extends StatelessWidget {
  final AddSubjectViewModel model;

  const AddSubjectFormFields(this.model);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.primaryIconTheme.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: <Widget>[
              const FormRequired(),
              ReactiveTextField(
                autofocus: true,
                formControl: model.subject,
                onEditingComplete: model.room.focus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Subject*',
                  prefixIcon: Icon(Icons.subject, color: iconColor),
                ),
              ),
              const FormSpacer(),
              ReactiveTextField(
                formControl: model.room,
                onEditingComplete: model.building.focus,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Room*',
                  prefixIcon: Icon(Icons.location_on, color: iconColor),
                ),
              ),
              const FormSpacer(),
              ReactiveTextField(
                formControl: model.building,
                onEditingComplete: model.teacher.focus,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Building',
                  prefixIcon: Icon(Icons.business, color: iconColor),
                ),
              ),
              const FormSpacer(),
              ReactiveTextField(
                formControl: model.teacher,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Teacher*',
                  prefixIcon: Icon(Icons.person, color: iconColor),
                ),
              ),
              const FormSpacer(),
              ReactiveSubjectColorPicker(model.color),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: theme.inputDecorationTheme.border!.borderSide,
              textStyle: theme.textTheme.bodyText1,
            ),
            onPressed: model.addSubject,
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
