import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';

class ScheduleField extends StatelessWidget {
  const ScheduleField({
    @required this.dayFieldBloc,
    @required this.startTimeBloc,
    @required this.endTimeBloc,
    @required this.onRemove,
  });

  final SelectFieldBloc dayFieldBloc;
  final InputFieldBloc<TimeOfDay, Object> startTimeBloc;
  final InputFieldBloc<TimeOfDay, Object> endTimeBloc;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownFieldBlocBuilder<String>(
                  selectFieldBloc: dayFieldBloc,
                  decoration: const InputDecoration(
                    labelText: 'Day',
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                  itemBuilder: (context, value) => value,
                  showEmptyItem: true,
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: onRemove,
                color: Colors.black,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: TimeFieldBlocBuilder(
                  timeFieldBloc: startTimeBloc,
                  format: DateFormat.jm(),
                  initialTime: TimeOfDay.now(),
                  decoration: InputDecoration(
                    labelText: 'Start time',
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Flexible(
                child: TimeFieldBlocBuilder(
                  timeFieldBloc: endTimeBloc,
                  format: DateFormat.jm(),
                  initialTime: TimeOfDay.now(),
                  decoration: InputDecoration(
                    labelText: 'End time',
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
