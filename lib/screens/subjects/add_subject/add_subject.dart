import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:school_life/models/subject.dart';
import 'package:stacked/stacked.dart';

import '../../../components/forms/form_required.dart';
import '../../../components/forms/form_spacer.dart';
import 'add_subject_viewmodel.dart';
import 'widgets/color_picker.dart';

class AddSubjectPage extends StatelessWidget {
  final Subject? subjectToEdit;

  const AddSubjectPage({Key? key, this.subjectToEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Subject',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: ViewModelBuilder<AddSubjectViewModel>.reactive(
        viewModelBuilder: () => AddSubjectViewModel(
          subjectToEdit: subjectToEdit,
        ),
        builder: (context, model, _) {
          if (model.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return ReactiveForm(
            onWillPop: model.canPop,
            formGroup: model.form,
            child: AddSubjectFormFields(model),
          );
        },
      ),
    );
  }
}

class AddSubjectFormFields extends StatelessWidget {
  final AddSubjectViewModel model;

  const AddSubjectFormFields(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.primaryIconTheme.color;

    return ListView(
      shrinkWrap: true,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: model.addSubject,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF82BD61),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text('Save', style: Theme.of(context).textTheme.button),
          ),
        ),
      ],
    );
  }
}
