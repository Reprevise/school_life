import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/bloc/add_subject_bloc.dart';
import 'package:school_life/routing/router.gr.dart';

class SubjectColorPicker extends StatefulWidget {
  const SubjectColorPicker(this.formBloc);

  final AddSubjectFormBloc formBloc;

  @override
  _SubjectColorPickerState createState() => _SubjectColorPickerState();
}

class _SubjectColorPickerState extends State<SubjectColorPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputFieldBloc<Color>, InputFieldBlocState<Color>>(
      bloc: widget.formBloc.colorField,
      builder: (BuildContext context, InputFieldBlocState<Color> state) {
        return InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select a color'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      availableColors: widget.formBloc.availableColors,
                      pickerColor: widget.formBloc.currentColor,
                      onColorChanged: (Color color) {
                        widget.formBloc.colorField.updateValue(color);
                        setState(() {});
                        Router.navigator.pop();
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: InputDecorator(
            decoration: InputDecoration(
              fillColor: state.value ?? Colors.transparent,
              filled: true,
              prefixIcon: Icon(
                Icons.color_lens,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
            child: Text(
              'Change color',
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
