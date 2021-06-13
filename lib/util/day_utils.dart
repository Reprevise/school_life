final Map<String, String> daysFromIntegerString = <String, String>{
  '1': 'Monday',
  '2': 'Tuesday',
  '3': 'Wednesday',
  '4': 'Thursday',
  '5': 'Friday',
  '6': 'Saturday',
  '7': 'Sunday',
};

final Map<String, int> daysToInteger = <String, int>{
  'Monday': DateTime.monday,
  'Tuesday': DateTime.tuesday,
  'Wednesday': DateTime.wednesday,
  'Thursday': DateTime.thursday,
  'Friday': DateTime.friday,
  'Saturday': DateTime.saturday,
  'Sunday': DateTime.sunday,
};

const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
const weekdaysWithWeekends = [...weekdays, 'Saturday', 'Sunday'];
