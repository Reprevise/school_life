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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.all(12),
      elevation: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: DropdownFieldBlocBuilder<String>(
                  selectFieldBloc: dayFieldBloc,
                  decoration: const InputDecoration(labelText: 'Day'),
                  itemBuilder: (context, value) => value,
                  showEmptyItem: false,
                ),
              ),
              Flexible(
                flex: 2,
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: onRemove,
                ),
              ),
            ],
          ),
          Flexible(
            flex: 2,
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TimeFieldBlocBuilder(
                    timeFieldBloc: startTimeBloc,
                    format: DateFormat.jm(),
                    initialTime: null,
                    decoration: InputDecoration(
                      labelText: 'Start time'
                    ),
                  ),
                  const SizedBox(width: 10),
                  TimeFieldBlocBuilder(
                    timeFieldBloc: endTimeBloc,
                    format: DateFormat.jm(),
                    initialTime: null,
                    decoration: InputDecoration(
                      labelText: 'End time'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
