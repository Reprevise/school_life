class Validators {
  static String maxLength(String value, int maxLength) {
    if (value.trim().length > maxLength)
      return 'Shorten to $maxLength characters please.';
    return null;
  }
}
