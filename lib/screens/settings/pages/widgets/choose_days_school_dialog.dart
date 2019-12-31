import 'package:flutter/material.dart';

class ChooseDaysOfSchoolDialog extends StatefulWidget {
  const ChooseDaysOfSchoolDialog({
    Key key,
    @required this.selectedDays,
    @required this.onSaved,
  }) : super(key: key);

  final Map<String, bool> selectedDays;
  final ValueChanged<Map<String, bool>> onSaved;

  @override
  _ChooseDaysOfSchoolDialogState createState() =>
      _ChooseDaysOfSchoolDialogState(selectedDays);
}

class _ChooseDaysOfSchoolDialogState extends State<ChooseDaysOfSchoolDialog> {
  _ChooseDaysOfSchoolDialogState(this._selectedDays);

  Map<String, bool> _selectedDays;

  @override
  Widget build(BuildContext context) {
    final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
    final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
    return AlertDialog(
      title: Text("What days do you have school?"),
      actions: <Widget>[
        MaterialButton(
          child: Text(
            "SAVE",
            style: TextStyle(color: _contentStyleColor),
          ),
          onPressed: () {
            widget.onSaved(_selectedDays);
            Navigator.pop(context);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Monday"),
              value: _selectedDays["1"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["1"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Tuesday"),
              value: _selectedDays["2"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["2"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Wednesday"),
              value: _selectedDays["3"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["3"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Thursday"),
              value: _selectedDays["4"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["4"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Friday"),
              value: _selectedDays["5"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["5"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Saturday"),
              value: _selectedDays["6"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["6"] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Sunday"),
              value: _selectedDays["7"],
              onChanged: (value) {
                setState(() {
                  _selectedDays["7"] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
