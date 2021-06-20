import 'package:hive/hive.dart';

import '../../models/holiday.dart';
import 'hive_helper.dart';

class HolidaysRepository {
  late final Box<Holiday> _holidaysDB;

  HolidaysRepository() {
    _holidaysDB = Hive.box(HiveBoxes.holidaysBox);
  }

  List<Holiday> get holidays => _holidaysDB.values.toList();

  Holiday getHoliday(String id) => _holidaysDB.get(id)!;

  Future<void> addHoliday(Holiday holiday) {
    return _holidaysDB.put(holiday.id, holiday);
  }
}
