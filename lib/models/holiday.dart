import 'package:hive/hive.dart';

import '../services/databases/hive_helper.dart';

part 'holiday.g.dart';

@HiveType(typeId: HiveHelper.holidayTypeID)
class Holiday extends HiveObject {
  Holiday({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;
}
