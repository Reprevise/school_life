import 'package:hive/hive.dart';
import 'package:school_life/models/subject.dart';

class SubjectsDBCreator {
  static const SUBJECTS_BOX = 'subjects_db';

  Future<void> init() async {
    await Hive.openBox<Subject>(SUBJECTS_BOX);
  }
}
