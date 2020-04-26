import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_life/bloc/add_subject_bloc.dart';
import 'package:school_life/util/random_color.dart';
import 'package:school_life/util/color_utils.dart';

class SubjectColorPicker extends StatefulWidget {
  const SubjectColorPicker(this.formBloc);

  final AddSubjectFormBloc formBloc;

  @override
  _SubjectColorPickerState createState() => _SubjectColorPickerState();
}

class _SubjectColorPickerState extends State<SubjectColorPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.formBloc.colorField,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              fillColor: state.value ?? Colors.transparent,
              filled: true,
              prefixIcon: Icon(
                Icons.color_lens,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  widget.formBloc.colorField.updateValue(RandomColor().next());
                  setState(() {});
                },
              ),
            ),
            child: Text(
              ColorUtils().toHex(state.value)?.toUpperCase() ?? 'Change color*',
              style: TextStyle(
                color: Theme.of(context).inputDecorationTheme.labelStyle.color,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Arial',
              ),
            ),
          ),
        );
      },
    );
  }
}
