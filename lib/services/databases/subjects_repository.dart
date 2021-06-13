import 'package:hive/hive.dart';

import '../../models/subject.dart';
import '../../models/time_block.dart';
import 'hive_helper.dart';

class SubjectsRepository {
  late final Box<Subject> _subjectsDB;

  SubjectsRepository() {
    _subjectsDB = Hive.box(HiveBoxes.subjectsBox);
  }

  int get nextID {
    if (subjects.isEmpty) {
      return 0;
    }
    final takenIDs = subjects.map((subject) => subject.id).toList();

    var id = 0;
    do {
      id++;
    } while (takenIDs.contains(id));
    return id;
  }

  List<Subject> get subjects => _subjectsDB.values.toList();

  Subject getSubject(int id) => _subjectsDB.getAt(id)!;

  List<Subject> get subjectsWithoutSchedule {
    return subjects.where((subject) => subject.schedule == null).toList();
  }

  List<Subject> get subjectsWithSchedule {
    return subjects.where((subject) => subject.schedule != null).toList();
  }

  List<Subject> getSubjectsWithSameDaySchedule(String dayOfWeek) {
    final _usableSubjects = <Subject>[];
    for (final subject in subjectsWithSchedule) {
      // final block = getTimeBlockFromDay(dayOfWeek, subject.schedule!);
      _usableSubjects.add(subject);
    }
    return _usableSubjects;
  }

  //? what if there is a class that appears many times in a day?
  TimeBlock getTimeBlockFromDay(String day, List<TimeBlock> schedule) {
    return schedule.firstWhere((element) => element.day == day);
  }

  Future<int> addSubject(Subject subject) {
    return _subjectsDB.add(subject);
  }
}
