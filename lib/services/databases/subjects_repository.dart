import 'package:hive/hive.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsRepository {
  SubjectsRepository() {
    _subjectsDB = Hive.box(DatabaseHelper.SUBJECTS_BOX);
  }

  Box<Subject> _subjectsDB;
  int get newID => getAllSubjects().length;

  List<Subject> getAllSubjects() {
    final List<Subject> data = _subjectsDB.values.toList();
    return data ?? <Subject>[];
  }

  Subject getSubject(int id) {
    return _subjectsDB.getAt(id);
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
