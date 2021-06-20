import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.locator.dart';
import '../../../util/popper.dart';
import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../services/databases/assignments_repository.dart';
import '../../../services/databases/subjects_repository.dart';

class AddAssignmentViewModel extends BaseViewModel with Popper {
  final assignmentsRepo = locator<AssignmentsRepository>();
  final subjectsRepo = locator<SubjectsRepository>();
  final navService = locator<NavigationService>();
  final Assignment? assignmentToEdit;
  late List<Subject> subjects;
  late FormGroup form;

  AddAssignmentViewModel({this.assignmentToEdit}) {
    subjects = subjectsRepo.subjects;
    form = FormGroup({
      'name': FormControl<String>(
        value: assignmentToEdit?.name ?? '',
        validators: [Validators.required],
      ),
      'dueDate': FormControl<DateTime>(
        value: assignmentToEdit?.dueDate,
        validators: [Validators.required],
      ),
      'subject': FormControl<Subject>(
        value: subjectsRepo.getSubject(assignmentToEdit?.subjectID),
        validators: [Validators.required],
      ),
      'details': FormControl<String>(
        value: assignmentToEdit?.details ?? '',
        validators: [Validators.required],
      ),
    });
  }

  FormControl<String> get name => form.control('name') as FormControl<String>;
  FormControl<DateTime> get dueDate =>
      form.control('dueDate') as FormControl<DateTime>;
  FormControl<Subject> get subject =>
      form.control('subject') as FormControl<Subject>;
  FormControl<String> get details =>
      form.control('details') as FormControl<String>;

  Future<void> addAssignment() async {
    final assignment = Assignment(
      id: assignmentToEdit?.id ?? const Uuid().v4(),
      name: name.value!.trim(),
      dueDate: dueDate.value!,
      subjectID: subject.value!.id,
      details: details.value!.trim(),
    );
    await assignmentsRepo.addAssignment(assignment);
    navService.back();
  }

  @override
  bool fieldsAreEmpty() {
    return name.isNullOrEmpty &&
        dueDate.isNull &&
        subject.isNull &&
        details.isNullOrEmpty;
  }
}
