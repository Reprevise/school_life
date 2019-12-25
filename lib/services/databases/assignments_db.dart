import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';

Box<Assignment> assignmentsDB;

class AssignmentsDBCreator {
  static const ASSIGNMENTS_BOX = 'assignments_db';

  Future<void> init() async {
    assignmentsDB = await Hive.openBox<Assignment>(ASSIGNMENTS_BOX);
  }
}
