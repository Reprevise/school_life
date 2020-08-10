import 'package:hive/hive.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/services/databases/db_helper.dart';

class HolidaysRepository {
  HolidaysRepository() {
    _holidaysDB = Hive.box(Databases.holidaysBox);
  }

  Box<Holiday> _holidaysDB;

  int get nextID {
    if (holidays.isEmpty) {
      return 0;
    }
    final takenIDs = holidays.map((holiday) => holiday.id).toList();

    var id = 0;
    do {
      id++;
    } while (takenIDs.contains(id));
    return id;
  }

  List<Holiday> get holidays {
    return _holidaysDB.values.toList() ?? <Holiday>[];
  }

  Holiday getHoliday(int id) {
    return _holidaysDB.getAt(id);
  }

  Future<int> addHoliday(Holiday holiday) {
    return _holidaysDB.add(holiday);
  }
}
