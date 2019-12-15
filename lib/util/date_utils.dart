class DateUtils {
  static DateTime getTodaysDate() {
    final DateTime now = DateTime.now();
    final int day = now.day;
    final int month = now.month;
    final int year = now.year;
    return DateTime(year, month, day);
  }
}
