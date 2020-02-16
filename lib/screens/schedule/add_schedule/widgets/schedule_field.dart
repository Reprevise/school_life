import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/components/forms/date_time_field.dart';

class ScheduleField extends StatefulWidget {
  const ScheduleField({
    Key key,
    @required this.dayFieldBloc,
    @required this.startTimeBloc,
    @required this.endTimeBloc,
    @required this.onRemove,
  }) : super(key: key);

  final SelectFieldBloc<String> dayFieldBloc;
  final InputFieldBloc<TimeOfDay> startTimeBloc;
  final InputFieldBloc<TimeOfDay> endTimeBloc;
  final VoidCallback onRemove;

  @override
  _ScheduleFieldState createState() => _ScheduleFieldState();
}

class _ScheduleFieldState extends State<ScheduleField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.all(12),
      elevation: 6,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: widget.onRemove,
            ),
          ),
          DropdownFieldBlocBuilder<String>(
            selectFieldBloc: widget.dayFieldBloc,
            decoration: const InputDecoration(labelText: 'Day'),
            itemBuilder: (context, value) => value,
            showEmptyItem: false,
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BlocBuilder<InputFieldBloc<TimeOfDay>,
                    InputFieldBlocState<TimeOfDay>>(
                  bloc: widget.startTimeBloc,
                  builder: (context, state) {
                    return TimeField(
                      labelText: 'Start time',
                      errorText: state.error,
                      isRequired: true,
                      selectedTime: widget.startTimeBloc.value,
                      onTimeChanged: (time) {
                        widget.startTimeBloc.updateValue(time);
                        setState(() {});
                      },
                    );
                  },
                ),
                const SizedBox(width: 10),
                BlocBuilder<InputFieldBloc<TimeOfDay>,
                    InputFieldBlocState<TimeOfDay>>(
                  bloc: widget.endTimeBloc,
                  builder: (context, state) {
                    return TimeField(
                      labelText: 'End time',
                      errorText: state.error,
                      isRequired: true,
                      selectedTime: widget.endTimeBloc.value,
                      onTimeChanged: (time) {
                        widget.endTimeBloc.updateValue(time);
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
