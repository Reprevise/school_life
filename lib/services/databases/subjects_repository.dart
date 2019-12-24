import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_db.dart';

class SubjectsRepository {
  static int get newID => getAllSubjects().length;

  static List<Subject> getAllSubjects() {
    final List<Subject> data = subjectsDB.values.toList();
    return data ?? [];
  }

  @deprecated
  static Future<List<Color>> getAvailableColors(
      List<Color> wantedColors) async {
    final List<Subject> allSubjects = getAllSubjects();
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

  static Map<int, Subject> getSubjectsMap() {
    final List<Subject> allSubjects = getAllSubjects();
    Map<int, Subject> subjectsByID = {};
    for (Subject subject in allSubjects) {
      subjectsByID[subject.id] = subject;
    }
    return subjectsByID;
  }

  static Future<Subject> getSubject(int id) async {
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
