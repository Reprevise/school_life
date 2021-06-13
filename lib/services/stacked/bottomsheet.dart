import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/time_block.dart';
import '../../util/day_utils.dart';
import '../settings/schedule.dart';

enum BottomSheetType { schedule }

void setupBottomSheetUi() {
  final bss = locator<BottomSheetService>();

  final builders = <BottomSheetType, SheetBuilder>{
    BottomSheetType.schedule: (_, sheetRequest, completer) =>
        _ScheduleBottomSheet(request: sheetRequest, completer: completer),
  };

  bss.setCustomSheetBuilders(builders);
}

class _ScheduleBottomSheet extends StatefulWidget {
  final SheetRequest request;
  final void Function(SheetResponse) completer;

  const _ScheduleBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  _ScheduleBottomSheetState createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<_ScheduleBottomSheet> {
  List<String> _getAvailableDays() {
    final ssh = locator<ScheduleSettingsHelper>();
    if (ssh.areWeekendsEnabled) {
      return weekdaysWithWeekends;
    }
    return weekdays;
  }

  String? nSelectedDay;
  TimeOfDay? nStartTime;
  TimeOfDay? nEndTime;

  @override
  Widget build(BuildContext context) {
    final timeNow = TimeOfDay.now();
    final hourFromNow = DateTime.now().add(Duration(hours: 1));
    final data = widget.request.customData as TimeBlock?;
    final availableDays = _getAvailableDays();
    var eSelectedDay = data?.day ?? availableDays.first;
    var eStartTime = data?.startTime ?? timeNow;
    var eEndTime = data?.endTime ?? TimeOfDay.fromDateTime(hourFromNow);

    return DraggableScrollableSheet(
      maxChildSize: 0.75,
      minChildSize: 0.75,
      expand: false,
      initialChildSize: 0.75,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFC0C0C0).withOpacity(0.50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text('Select day'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: availableDays
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    value: nSelectedDay ?? eSelectedDay,
                    iconEnabledColor: Colors.black,
                    dropdownColor: Color(0xFFC4C4C4),
                    style: TextStyle(color: Colors.black),
                    onChanged: (newValue) {
                      if (newValue == null) return;
                      setState(() {
                        nSelectedDay = newValue;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text('Start time'),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text('End time'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Color(0xFFC4C4C4),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: nStartTime ?? eStartTime,
                        );
                        if (result == null) return;
                        setState(() {
                          nStartTime = result;
                        });
                      },
                      child: Text(
                        '${(nStartTime ?? eStartTime).format(context)}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 6,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Color(0xFFC4C4C4),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: nEndTime ?? eEndTime,
                        );
                        if (result == null) return;
                        setState(() {
                          nEndTime = result;
                        });
                      },
                      child: Text(
                        '${(nEndTime ?? eEndTime).format(context)}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  widget.completer(
                    SheetResponse(
                      confirmed: true,
                      responseData: TimeBlock(
                        day: eSelectedDay,
                        startTime: eStartTime,
                        endTime: eEndTime,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF82BD61),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text('Save', style: Theme.of(context).textTheme.button),
              )
            ],
          ),
        );
      },
    );
  }
}
