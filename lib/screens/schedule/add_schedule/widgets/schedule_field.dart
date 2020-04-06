import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/components/forms/date_time_field.dart';

class ScheduleField extends StatelessWidget {
  const ScheduleField({
    Key key,
    @required this.dayFieldBloc,
    @required this.startTimeBloc,
    @required this.endTimeBloc,
    @required this.onRemove,
  }) : super(key: key);

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
                  BlocBuilder(
                    bloc: startTimeBloc,
                    builder: (context, state) {
                      return TimeField(
                        labelText: 'Start time',
                        errorText: state.error,
                        isRequired: true,
                        selectedTime: startTimeBloc.value,
                        onTimeChanged: startTimeBloc.updateValue,
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder(
                    bloc: endTimeBloc,
                    builder: (context, state) {
                      return TimeField(
                        labelText: 'End time',
                        errorText: state.error,
                        isRequired: true,
                        selectedTime: endTimeBloc.value,
                        onTimeChanged: endTimeBloc.updateValue,
                      );
                    },
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
