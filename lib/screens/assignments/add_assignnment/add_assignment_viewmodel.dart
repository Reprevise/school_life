import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
  late List<Subject> subjects;

  final form = FormGroup({
    'name': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'dueDate': FormControl<DateTime>(
      validators: [Validators.required],
    ),
    'subject': FormControl<Subject>(
      validators: [Validators.required],
    ),
    'details': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
  });

  FormControl<String> get name => form.control('name') as FormControl<String>;
  FormControl<DateTime> get dueDate =>
      form.control('dueDate') as FormControl<DateTime>;
  FormControl<Subject> get subject =>
      form.control('subject') as FormControl<Subject>;
  FormControl<String> get details =>
      form.control('details') as FormControl<String>;

  void initialize() {
    subjects = subjectsRepo.subjects;
  }

  Future<void> addAssignment() async {
    final assignment = Assignment(
      id: assignmentsRepo.nextID,
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
