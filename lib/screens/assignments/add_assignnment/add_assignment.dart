import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:school_life/models/assignment.dart';
import 'package:stacked/stacked.dart';

import '../../../components/forms/form_required.dart';
import '../../../components/forms/form_spacer.dart';
import '../../../models/subject.dart';
import '../../../util/date_utils.dart';
import 'add_assignment_viewmodel.dart';

class AddAssignmentPage extends StatelessWidget {
  final Assignment? assignmentToEdit;

  const AddAssignmentPage({Key? key, this.assignmentToEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Assignment',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: ViewModelBuilder<AddAssignmentViewModel>.reactive(
        viewModelBuilder: () => AddAssignmentViewModel(
          assignmentToEdit: assignmentToEdit,
        ),
        builder: (context, model, _) {
          if (model.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return ReactiveForm(
            onWillPop: () => model.canPop(),
            formGroup: model.form,
            child: _AddAssignmentForm(model),
          );
        },
      ),
    );
  }
}

class _AddAssignmentForm extends StatelessWidget {
  const _AddAssignmentForm(this.model);

  final AddAssignmentViewModel model;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMMMd();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      children: <Widget>[
        const FormRequired(),
        ReactiveTextField(
          formControl: model.name,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Assignment Name*',
            prefixIcon: Icon(
              Icons.assignment,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const FormSpacer(),
        ReactiveDateTimePicker(
          formControl: model.dueDate,
          valueAccessor: DateTimeValueAccessor(dateTimeFormat: format),
          firstDate: DateTime.now().onlyDate,
          lastDate: DateTime.now().addYears(1),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            labelText: 'Due date*',
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const FormSpacer(),
        ReactiveDropdownField<Subject>(
          formControl: model.subject,
          items: model.subjects
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
              .toList(),
          hint: const Text('Subject*'),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.school,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const FormSpacer(),
        SizedBox(
          height: 150,
          child: ReactiveTextField(
            formControl: model.details,
            expands: true,
            minLines: null,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              labelText: 'Details',
              prefixIcon: Icon(
                Icons.subject,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: model.addAssignment,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF82BD61),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              model.assignmentToEdit == null ? 'Add' : 'Save',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ],
    );
  }
}
