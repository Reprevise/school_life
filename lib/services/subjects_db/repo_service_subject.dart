import 'subjects_db.dart';
import 'package:school_life/util/models/subject.dart';

class RepositoryServiceSubject {
  static Future<List<Subject>> getAllSubjects() async {
    final sql = '''SELECT * FROM ${SubjectDBCreator.SUBJECTS_TABLE}
    WHERE ${SubjectDBCreator.IS_DELETED} == 0''';
    final data = await db.rawQuery(sql);
    List<Subject> subjects = List();

    for (final node in data) {
      final subject = Subject.fromJson(node);
      subjects.add(subject);
    }
    return subjects;
  }

  static Future<bool> checkIfSubNameExists(String subName) async {
    List<dynamic> params = [subName];
    final data = await db.rawQuery(
        '''SELECT * FROM ${SubjectDBCreator.SUBJECTS_TABLE}
    WHERE ${SubjectDBCreator.IS_DELETED} == 0 AND LOWER(${SubjectDBCreator.NAME}) == ?''',
        params);
    if (data.isNotEmpty) return Future.value(true);
    return Future.value(false);
  }

  static Future<Subject> getSubject(int id) async {
    final sql = '''SELECT * FROM ${SubjectDBCreator.SUBJECTS_TABLE}
    WHERE ${SubjectDBCreator.ID} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final subject = Subject.fromJson(data.first);
    return subject;
  }

  static Future<void> addSubject(Subject subject) async {
    final sql = '''INSERT INTO ${SubjectDBCreator.SUBJECTS_TABLE}
    (
      ${SubjectDBCreator.ID},
      ${SubjectDBCreator.NAME},
      ${SubjectDBCreator.ROOM},
      ${SubjectDBCreator.BUILDING},
      ${SubjectDBCreator.TEACHER},
      ${SubjectDBCreator.COLOR},
      ${SubjectDBCreator.IS_DELETED}
    )
    VALUES (?,?,?,?,?,?,?)''';
    List<dynamic> params = [
      subject.id,
      subject.name,
      subject.room,
      subject.building,
      subject.teacher,
      subject.color,
      subject.isDeleted ? 1 : 0,
    ];
    await db.rawInsert(sql, params);
  }

  static Future<void> deleteSubject(Subject subject) async {
    final sql = '''UPDATE ${SubjectDBCreator.SUBJECTS_TABLE}
    SET ${SubjectDBCreator.IS_DELETED} = 1
    WHERE ${SubjectDBCreator.ID} == ?
    ''';

    List<dynamic> params = [subject.id];

    await db.rawUpdate(sql, params);
  }

  static Future<void> updateSubject(Subject subject) async {
    final sql = '''UPDATE ${SubjectDBCreator.SUBJECTS_TABLE}
    SET ${SubjectDBCreator.NAME} = ?
    SET ${SubjectDBCreator.ROOM} = ?
    SET ${SubjectDBCreator.BUILDING} = ?
    SET ${SubjectDBCreator.TEACHER} = ?
    SET ${SubjectDBCreator.COLOR} = ?
    WHERE ${SubjectDBCreator.ID} == ?
    ''';

    List<dynamic> params = [
      subject.name,
      subject.room,
      subject.building,
      subject.teacher,
      subject.color,
      subject.id,
    ];

    await db.rawUpdate(sql, params);
  }

  static Future<int> subjectsCount() async {
    final data = await db.rawQuery(
        '''SELECT COUNT(*) FROM ${SubjectDBCreator.SUBJECTS_TABLE}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}
