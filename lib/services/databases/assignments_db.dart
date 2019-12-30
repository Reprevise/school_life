import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';

class AssignmentsDBCreator {
  static const ASSIGNMENTS_BOX = 'assignments_db';

  Future<void> init() async {
    await Hive.openBox<Assignment>(ASSIGNMENTS_BOX);
  }
}
