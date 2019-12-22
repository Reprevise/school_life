import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_db.dart';

class SubjectsRepository {
  static Future<List<Subject>> getAllSubjects() async {
    final data = await subjectsDB.query(
      SubjectsDBCreator.SUBJECTS_TABLE,
      where: '${SubjectsDBCreator.IS_DELETED} = 0',
    );
    List<Subject> subjects =
        data.map((node) => Subject.fromJson(node)).toList();

    return subjects;
  }

  // static Future<Subject> getSubjectFromName(String subjectName) async {
  //   final data = await subjectsDB.query(
  //     SubjectsDBCreator.SUBJECTS_TABLE,
  //     where: '${SubjectsDBCreator.IS_DELETED} = 0 AND '
  //         'LOWER(${SubjectsDBCreator.NAME}) = ?',
  //     whereArgs: [subjectName.toLowerCase()],
  //   );
  //   if (data.isEmpty) return null;
  //   if (data.length > 1) throw Exception('Many subjects with the same name!');
  //   return Subject.fromJson(data.first);
  // }

  static Future<List<Color>> getAvailableColors(
      List<Color> wantedColors) async {
    final List<Subject> allSubjects = await getAllSubjects();
    if (allSubjects.isEmpty) return wantedColors;
    final List<int> subjectColorValues =
        allSubjects.map((subject) => subject.colorValue).toList();
    final List<int> availableColorValues =
        wantedColors.map((color) => color.value).toList();
    for (int colorValue in subjectColorValues) {
      if (availableColorValues.contains(colorValue)) {
        availableColorValues.remove(colorValue);
      }
    }
    final List<Color> availableColors =
        availableColorValues.map((colorValue) => Color(colorValue)).toList();
    return availableColors;
  }

  static Future<Subject> getSubject(int id) async {
    final data = await subjectsDB.query(SubjectsDBCreator.SUBJECTS_TABLE,
        where: '${SubjectsDBCreator.ID} = ?', whereArgs: [id]);

    final subject = Subject.fromJson(data.first);
    return subject;
  }

  static void addSubject(Subject subject) {
    subjectsDB.insert(SubjectsDBCreator.SUBJECTS_TABLE, subject.toDBJson());
  }

  static void deleteSubject(Subject subject) {
    subjectsDB.update(
      SubjectsDBCreator.SUBJECTS_TABLE,
      {SubjectsDBCreator.IS_DELETED: 1},
      where: '${SubjectsDBCreator.ID} = ?',
      whereArgs: [subject.id],
    );
  }

  static Future<void> updateSubject(Subject subject) async {
    subjectsDB.update(
      SubjectsDBCreator.SUBJECTS_TABLE,
      subject.toDBUpdatableValuesJson(),
      where: '${SubjectsDBCreator.ID} = ?',
      whereArgs: [subject.id],
    );
  }

  static Future<int> getNewSubjectID() async {
    final sql = 'SELECT COUNT(*) FROM ${SubjectsDBCreator.SUBJECTS_TABLE}';
    final data = await subjectsDB.rawQuery(sql);

    int count = data[0].values.first;
    return count++;
  }
}
