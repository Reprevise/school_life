import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/util/date_utils.dart';

class DateField extends StatelessWidget {
  const DateField({
    Key key,
    @required this.labelText,
    @required this.errorText,
    @required this.selectedDate,
    @required this.onDateChanged,
    @required this.format,
  }) : super(key: key);

  final String labelText;
  final String errorText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final DateFormat format;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime date = DateTime.now().onlyDate;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: date,
      lastDate: date.addYears(5),
    );
    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return _InputField(
      valueText: format.format(selectedDate),
      labelText: labelText,
      errorText: errorText,
      valueStyle: valueStyle,
      onPressed: () => _selectDate(context),
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    Key key,
    @required this.labelText,
    @required this.errorText,
    @required this.selectedTime,
    @required this.onTimeChanged,
  }) : super(key: key);

  final String errorText;
  final String labelText;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return Expanded(
      child: _InputField(
        valueText: selectedTime?.format(context) ?? '',
        valueStyle: valueStyle,
        labelText: labelText,
        errorText: errorText,
        onPressed: () => _selectTime(context),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key key,
    @required this.labelText,
    @required this.valueText,
    @required this.errorText,
    @required this.onPressed,
    this.valueStyle,
    this.decoration = const InputDecoration(),
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final String errorText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: decoration.copyWith(
          labelText: labelText,
          errorText: errorText,
        ),
        baseStyle: valueStyle,
        child: Text(valueText, style: valueStyle),
      ),
    );
  }
}
