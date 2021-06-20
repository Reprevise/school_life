import 'dart:ui';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../util/popper.dart';
import '../../../models/subject.dart';
import '../../../services/databases/subjects_repository.dart';

class AddSubjectViewModel extends BaseViewModel with Popper {
  final Subject? subjectToEdit;

  late final FormGroup form;
  late final SubjectsRepository subjectsRepo;
  late final NavigationService ns;

  AddSubjectViewModel({this.subjectToEdit}) {
    subjectsRepo = locator<SubjectsRepository>();
    ns = locator<NavigationService>();
    form = FormGroup({
      'subject': FormControl<String>(
        value: subjectToEdit?.name ?? '',
        validators: [Validators.required],
      ),
      'room': FormControl<String>(
        value: subjectToEdit?.room ?? '',
        validators: [Validators.required],
      ),
      'building': FormControl<String>(
        value: subjectToEdit?.building ?? '',
      ),
      'teacher': FormControl<String>(
        value: subjectToEdit?.teacher ?? '',
        validators: [Validators.required],
      ),
      'color': FormControl<Color>(
        value: subjectToEdit?.color,
      ),
    });
  }

  FormControl<String> get subject =>
      form.control('subject') as FormControl<String>;

  FormControl<String> get room => form.control('room') as FormControl<String>;

  FormControl<String> get building =>
      form.control('building') as FormControl<String>;

  FormControl<String> get teacher =>
      form.control('teacher') as FormControl<String>;

  FormControl<Color> get color => form.control('color') as FormControl<Color>;

  @override
  bool fieldsAreEmpty() {
    return subject.isNullOrEmpty &&
        room.isNullOrEmpty &&
        building.isNullOrEmpty &&
        teacher.isNullOrEmpty;
  }

  Future<void> promptToAddSchedule() async {
    final response = await ds.showDialog(
      title: 'Add schedule?',
      description: 'Would you like to add a schedule for ${subject.value}?',
      buttonTitle: 'ADD SCHEDULE',
      cancelTitle: 'NO',
      barrierDismissible: false,
    );
    if (response!.confirmed) {
      await ns.navigateTo(Routes.addSchedulePage);
    } else {
      ns.back();
    }
  }

  Future<void> addSubject() async {
    if (form.valid) {
      final subjectObject = Subject(
        id: subjectToEdit?.id ?? const Uuid().v4(),
        name: subject.value!.trim(),
        room: room.value!.trim(),
        building: building.value!.trim(),
        teacher: teacher.value!.trim(),
        color: color.value!,
      );

      try {
        await runBusyFuture(
          subjectsRepo.addSubject(subjectObject),
          throwException: true,
        );
        await promptToAddSchedule();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
