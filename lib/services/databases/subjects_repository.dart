import 'package:hive/hive.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsRepository {
  SubjectsRepository() {
    _subjectsDB = Hive.box(DatabaseHelper.SUBJECTS_BOX);
  }

  Box<Subject> _subjectsDB;
  
  int get newID => allSubjects.length;

  List<Subject> get allSubjects {
    final List<Subject> data = _subjectsDB.values.toList();
    return data ?? <Subject>[];
  }

  Subject getSubject(int id) {
    return _subjectsDB.getAt(id);
  }

  List<Subject> getSubjectsWithoutSchedule() {
    return allSubjects
        .where((Subject subject) => subject.schedule == null)
        .toList();
  }

  List<Subject> getSubjectsWithSameDaySchedule(String dayOfWeek) {
    return allSubjects
        .where((Subject subject) => subject.schedule != null)
        .where((Subject subject) => subject.schedule.containsKey(dayOfWeek))
        .toList();
  }

  void addSubject(Subject subject) {
    _subjectsDB.add(subject);
  }

  void deleteSubject(Subject subject) {
    _subjectsDB.delete(subject.id);
  }

  Future<void> updateSubject(Subject subject) async {
    _subjectsDB.put(subject.id, subject);
  }
}
