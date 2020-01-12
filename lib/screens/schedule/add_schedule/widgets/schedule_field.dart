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
  void initState() {
    super.initState();
    widget.dayFieldBloc.listen((SelectFieldBlocState<String> state) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: widget.onRemove,
              )
            ],
          ),
          DropdownFieldBlocBuilder<String>(
            selectFieldBloc: widget.dayFieldBloc,
            decoration: const InputDecoration(labelText: 'Day'),
            itemBuilder: (BuildContext context, String value) => value,
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
                  builder: (BuildContext context,
                      InputFieldBlocState<TimeOfDay> state) {
                    return TimeField(
                      labelText: '${widget.dayFieldBloc.value} start time',
                      errorText: state.error,
                      selectedTime: null,
                      onTimeChanged: widget.startTimeBloc.updateValue,
                    );
                  },
                ),
                const SizedBox(width: 10),
                BlocBuilder<InputFieldBloc<TimeOfDay>,
                    InputFieldBlocState<TimeOfDay>>(
                  bloc: widget.endTimeBloc,
                  builder: (BuildContext context,
                      InputFieldBlocState<TimeOfDay> state) {
                    return TimeField(
                      labelText: '${widget.dayFieldBloc.value} end time',
                      errorText: state.error,
                      selectedTime: null,
                      onTimeChanged: widget.endTimeBloc.updateValue,
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
