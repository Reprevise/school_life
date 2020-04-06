import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/util/date_utils.dart';

class DateField extends StatelessWidget {
  const DateField({
    @required this.labelText,
    @required this.errorText,
    @required this.selectedDate,
    @required this.onDateChanged,
    @required this.format,
    @required this.isRequired,
  });

  final String labelText;
  final String errorText;
  final DateTime selectedDate;
  final bool isRequired;
  final ValueChanged<DateTime> onDateChanged;
  final DateFormat format;

  Future<void> _selectDate(BuildContext context) async {
    final date = DateTime.now().onlyDate;
    final picked = await showDatePicker(
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
    final valueStyle = Theme.of(context).accentTextTheme.bodyText2;
    return _InputField(
      valueText: format.format(selectedDate),
      labelText: labelText,
      errorText: errorText,
      valueStyle: valueStyle,
      isRequired: isRequired,
      onPressed: () => _selectDate(context),
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    @required this.labelText,
    @required this.errorText,
    @required this.selectedTime,
    @required this.onTimeChanged,
    @required this.isRequired,
  });

  final String errorText;
  final String labelText;
  final TimeOfDay selectedTime;
  final bool isRequired;
  final ValueChanged<TimeOfDay> onTimeChanged;

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).accentTextTheme.bodyText2;
    return Expanded(
      child: _InputField(
        valueText: selectedTime?.format(context) ?? '',
        valueStyle: valueStyle,
        labelText: labelText,
        errorText: errorText,
        isRequired: isRequired,
        onPressed: () => _selectTime(context),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    @required this.labelText,
    @required this.valueText,
    @required this.errorText,
    @required this.onPressed,
    @required this.isRequired,
    this.valueStyle,
    this.decoration = const InputDecoration(),
  });

  final String labelText;
  final String valueText;
  final String errorText;
  final TextStyle valueStyle;
  final bool isRequired;
  final VoidCallback onPressed;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: decoration.copyWith(
          labelText: isRequired ? '$labelText*' : labelText,
          errorText: errorText,
        ),
        baseStyle: valueStyle,
        child: Text(valueText, style: valueStyle),
      ),
    );
  }
}
