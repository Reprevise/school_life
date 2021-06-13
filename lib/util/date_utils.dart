extension DateUtils on DateTime {
  DateTime get onlyDate => DateTime(year, month, day);
}

class ExtraDateUtils {
  static bool isBetweenOrEqual(DateTime date, DateTime start, DateTime end) {
    final sDate = date.onlyDate;
    final sStart = start.onlyDate;
    final sEnd = end.onlyDate;

    // after start date or before end date
    if (sDate.isAfter(sStart) && sDate.isBefore(sEnd)) {
      return true;
    }
    // same date as start or end
    if (sDate.isAtSameMomentAs(sStart) || sDate.isAtSameMomentAs(sEnd)) {
      return true;
    }
    return false;
  }
}
