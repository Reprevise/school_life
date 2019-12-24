import 'package:hive/hive.dart';
import 'package:school_life/models/subject.dart';

Box<Subject> subjectsDB;

class SubjectsDBCreator {
  static const SUBJECTS_TABLE = 'subjects';
  static const ID = '_id';
  static const NAME = 'name';
  static const ROOM = 'room';
  static const BUILDING = 'building';
  static const TEACHER = 'teacher';
  static const COLOR = 'color';
  static const IS_DELETED = 'isDeleted';

  Future<void> init() async {
    subjectsDB = await Hive.openBox<Subject>('subjects_db');
  }
}
