import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_db.dart';

class SubjectsRepository {
  static int get newID => getAllSubjects().length;

  static List<Subject> getAllSubjects() {
    final List<Subject> data = subjectsDB.values.toList();
    return data ?? [];
  }

  static Map<int, Subject> getSubjectsMap() {
    final List<Subject> allSubjects = getAllSubjects();
    Map<int, Subject> subjectsByID = {};
    for (Subject subject in allSubjects) {
      subjectsByID[subject.id] = subject;
    }
    return subjectsByID;
  }

  static Subject getSubject(int id) {
    return subjectsDB.getAt(id);
  }

  static void addSubject(Subject subject) {
    subjectsDB.add(subject);
  }

  static void deleteSubject(Subject subject) {
    subjectsDB.delete(subject.id);
  }

  static Future<void> updateSubject(Subject subject) async {
    subjectsDB.put(subject.id, subject);
  }
}
