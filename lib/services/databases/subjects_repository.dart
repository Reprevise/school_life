import 'package:hive/hive.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/models/time_block.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsRepository {
  SubjectsRepository() {
    _subjectsDB = Hive.box(Databases.subjectsBox);
  }

  Box<Subject> _subjectsDB;

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

  List<Subject> get subjects {
    final data = _subjectsDB.values.toList();
    return data ?? <Subject>[];
  }

  Subject getSubject(int id) {
    return _subjectsDB.getAt(id);
  }

  List<Subject> get subjectsWithoutSchedule {
    return subjects.where((subject) => subject.schedule == null).toList();
  }

  List<Subject> get subjectsWithSchedule {
    return subjects.where((subject) => subject.schedule != null).toList();
  }

  List<Subject> getSubjectsWithSameDaySchedule(String dayOfWeek) {
    final _usableSubjects = <Subject>[];
    for (final subject in subjectsWithSchedule) {
      final block = getTimeBlockFromDay(dayOfWeek, subject.schedule);
      if (block != null) _usableSubjects.add(subject);
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
