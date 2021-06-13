import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveSubjectColorPicker extends ReactiveFormField<Color, Color> {
  ReactiveSubjectColorPicker(FormControl<Color> formControl)
      : super(
          formControl: formControl,
          builder: (field) => FastColorPicker(
            selectedColor: field.value ?? Colors.white,
            onColorSelected: field.didChange,
          ),
        );

  @override
  ReactiveFormFieldState<Color, Color> createState() =>
      ReactiveFormFieldState<Color, Color>();
}

// class _SubjectColorPicker extends StatelessWidget {
//   final Color? value;
//   final Function(Color) onColorChanged;

//   const _SubjectColorPicker({
//     Key? key,
//     required this.value,
//     required this.onColorChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InputDecorator(
//       decoration: InputDecoration(
//         fillColor: value ?? Colors.transparent,
//         filled: true,
//         prefixIcon: Icon(
//           Icons.color_lens,
//           color: Theme.of(context).primaryIconTheme.color,
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(Icons.refresh),
//           onPressed: () => onColorChanged(RandomColor().next()),
//         ),
//       ),
//       child: Text(
//         ColorUtils().toHex(value)?.toUpperCase() ?? 'Change color*',
//         style: Theme.of(context).textTheme.subtitle1,
//       ),
//     );
//   }
// }
