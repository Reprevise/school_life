import 'package:hive/hive.dart';

import '../../models/holiday.dart';
import 'hive_helper.dart';

class HolidaysRepository {
  late final Box<Holiday> _holidaysDB;

  HolidaysRepository() {
    _holidaysDB = Hive.box(HiveBoxes.holidaysBox);
  }

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

  List<Holiday> get holidays => _holidaysDB.values.toList();

  Holiday getHoliday(int id) => _holidaysDB.getAt(id)!;

  Future<int> addHoliday(Holiday holiday) {
    return _holidaysDB.add(holiday);
  }
}
