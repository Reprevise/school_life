import 'package:flutter/material.dart';

import 'subjects_db.dart';
import 'package:school_life/models/subject.dart';

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
    List<dynamic> params = [subName.toLowerCase()];
    final data = await db.rawQuery(
        '''SELECT * FROM ${SubjectDBCreator.SUBJECTS_TABLE}
    WHERE ${SubjectDBCreator.IS_DELETED} == 0 AND LOWER(${SubjectDBCreator.NAME}) == ?''',
        params);
    if (data.isNotEmpty) return Future.value(true);
    return Future.value(false);
  }

  static Future<Subject> getSubjectFromName(String subjectName) async {
    List<dynamic> params = [subjectName.toLowerCase()];
    final data = await db.rawQuery(
        '''SELECT * FROM ${SubjectDBCreator.SUBJECTS_TABLE}
    WHERE ${SubjectDBCreator.IS_DELETED} == 0 AND LOWER(${SubjectDBCreator.NAME}) == ?''',
        params);
    if (data.length > 1) throw Exception('Many subjects with the same name!');
    return Subject.fromJson(data.first);
  }

  static Future<List<Color>> getAvailableColors(
      List<Color> wantedColors) async {
    final List<Subject> allSubjects = await getAllSubjects();
    if (allSubjects.isEmpty) return Future.value(wantedColors);
    final List<int> subjectColorValues = [];
    final List<int> availableColorValues = [];
    wantedColors.forEach((color) => availableColorValues.add(color.value));
    allSubjects
        .forEach((subject) => subjectColorValues.add(subject.colorValue));
    for (int subjectColorValue in subjectColorValues) {
      if (availableColorValues.contains(subjectColorValue))
        availableColorValues.remove(subjectColorValue);
    }
    final List<Color> availableColors = [];
    availableColorValues
        .forEach((colorValue) => availableColors.add(Color(colorValue)));
    return Future.value(availableColors);
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
      subject.colorValue,
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
      subject.colorValue,
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
