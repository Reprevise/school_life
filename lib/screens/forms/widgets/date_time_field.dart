import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/util/date_utils.dart';

class DateField extends StatelessWidget {
  const DateField({
    Key key,
    this.labelText,
    @required this.selectedDate,
    @required this.onDateChanged,
    @required this.format,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final DateFormat format;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime date = DateTime.now().todaysDate;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: date,
      lastDate: date.addYears(5),
    );
    if (picked != null && picked != selectedDate) onDateChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: format.format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        )
      ],
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    Key key,
    this.labelText,
    this.selectedTime,
    this.onTimeChanged,
  }) : super(key: key);

  final String labelText;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) onTimeChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        )
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.labelText = "",
    this.valueText,
    this.valueStyle,
    this.onPressed,
    this.child,
    this.decoration = const InputDecoration(),
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: decoration.copyWith(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
