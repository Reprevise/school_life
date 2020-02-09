extension DateUtils on DateTime {
  DateTime get onlyDate => DateTime(year, month, day);

  DateTime addYears(int years) {
    return add(Duration(days: 365 * years));
  }

  DateTime subtractYears(int years) {
    return subtract(Duration(days: 365 * years));
  }
}
