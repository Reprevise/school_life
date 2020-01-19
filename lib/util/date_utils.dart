
extension DateUtils on DateTime {
  DateTime get onlyDate => DateTime(year, month, day);

  DateTime addYears(int years) {
    return add(Duration(days: 365 * years));
  }
}
