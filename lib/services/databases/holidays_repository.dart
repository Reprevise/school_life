import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/services/databases/db_helper.dart';

@singleton
@injectable
class HolidaysRepository {
  HolidaysRepository() {
    _holidaysDB = Hive.box(Databases.HOLIDAYS_BOX);
  }

  Box<Holiday> _holidaysDB;

  int get nextID {
    if (holidays.isEmpty) {
      return 0;
    }
    final List<int> takenIDs =
        holidays.map((Holiday holiday) => holiday.id).toList();

    int id = 0;
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
