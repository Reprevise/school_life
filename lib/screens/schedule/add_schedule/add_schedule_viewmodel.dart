import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../util/popper.dart';
import '../../../models/subject.dart';
import '../../../models/time_block.dart';
import '../../../services/databases/subjects_repository.dart';
import '../../../services/stacked/bottomsheet.dart';
import '../../../util/day_utils.dart';

class AddScheduleViewModel extends BaseViewModel with Popper {
  final subjects = <Subject>[];
  final subjectsRepo = locator<SubjectsRepository>();
  final bss = locator<BottomSheetService>();

  final form = FormGroup({
    'subject': FormControl<Subject>(validators: [Validators.required]),
    'scheduleItems': FormArray<TimeBlock>([]),
  });

  FormControl<Subject> get subject =>
      form.control('subject') as FormControl<Subject>;

  FormArray<TimeBlock> get scheduleItems =>
      form.control('scheduleItems') as FormArray<TimeBlock>;

  void initialize() {
    subjects.addAll(subjectsRepo.subjectsWithoutSchedule);
  }

  void addTimeBlock(TimeBlock timeBlock, [int? index]) {
    if (index != null) {
      scheduleItems.insert(
        index,
        FormControl(
          value: timeBlock,
          validators: [Validators.required],
        ),
      );
      return;
    }
    scheduleItems.add(
      FormControl(
        value: timeBlock,
        validators: [Validators.required],
      ),
    );
  }

  void removeTimeBlock(int index) {
    scheduleItems.removeAt(index);
    notifyListeners();
  }

  Future<void> openScheduleSheet([TimeBlock? tBlock, int? index]) async {
    final response = await bss.showCustomSheet(
      variant: BottomSheetType.schedule,
      customData: tBlock,
    );
    if (response == null && tBlock != null && index != null) {
      // in case user cancels edit
      return;
    } else if (response != null && tBlock == null && index == null) {
      // user creates new time block
      addTimeBlock(response.responseData);
    } else if (response != null && tBlock != null && index != null) {
      // user edites time block
      removeTimeBlock(index);
      addTimeBlock(response.responseData, index);
    }
    notifyListeners();
  }

  @override
  bool fieldsAreEmpty() {
    return subject.isNull && scheduleItems.value!.isEmpty;
  }

  void addSchedule() async {
    if (!form.valid) {
      //! do something
      return;
    }

    subject.value!.schedule = sortMap(subject.value!.schedule!);
    await subject.value!.save();
  }

  List<TimeBlock> sortMap(List<TimeBlock> unsortedSchedule) {
    final sortedSchedule = unsortedSchedule
      ..sort((blockOne, blockTwo) {
        final numberOne = daysToInteger[blockOne.day];
        final numberTwo = daysToInteger[blockTwo.day];
        return numberOne!.compareTo(numberTwo!);
      });
    return sortedSchedule;
  }

  //! fix this
  // Map<String, dynamic>? notSameStartTime(AbstractControl<dynamic> control) {
  //   for (final subject in subjects) {
  //     // TODO: ensure a subject's time is not within another subject's time
  //     final block =
  //         subjectsRepo.getTimeBlockFromDay(selectedDay, subject.schedule!);

  //     if (block.startTime == time) {
  //       return {'sameStartTime': true};
  //     }
  //   }
  //   return null;
  // }
}
