import 'package:hive/hive.dart';

import '../../models/subject.dart';
import '../../models/time_block.dart';
import 'hive_helper.dart';

class SubjectsRepository {
  late final Box<Subject> _subjectsDB;

  SubjectsRepository() {
    _subjectsDB = Hive.box(HiveBoxes.subjectsBox);
  }

  List<Subject> get subjects => _subjectsDB.values.toList();

  Subject? getSubject(String? id) {
    if (id == null) return null;
    return _subjectsDB.get(id)!;
  }

  List<Subject> get subjectsWithoutSchedule {
    return subjects.where((subject) => subject.schedule.isEmpty).toList();
  }

  List<Subject> get subjectsWithSchedule {
    return subjects.where((subject) => subject.schedule.isNotEmpty).toList();
  }

  List<Subject> getSubjectsWithSameDaySchedule(String dayOfWeek) {
    final _usableSubjects = <Subject>[];
    for (final subject in subjectsWithSchedule) {
      final block = getTimeBlockFromDay(dayOfWeek, subject.schedule);
      if (block != null) {
        _usableSubjects.add(subject);
      }
    }
    return _usableSubjects;
  }

  //? what if there is a class that appears many times in a day?
  TimeBlock? getTimeBlockFromDay(String day, List<TimeBlock> schedule) {
    try {
      final value = schedule.firstWhere((element) => element.day == day);
      return value;
    } on StateError {
      return null;
    }
  }

  Future<void> addSubject(Subject subject) async {
    await _subjectsDB.put(subject.id, subject);
  }
}
