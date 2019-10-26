import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final IconData prefixIcon;
  final String hintText;
  final String attribute;
  final String initialValue;
  final Widget suffix;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final bool autofocus;
  final List<String Function(dynamic)> validators;

  CustomFormField(
      {Key key,
      @required this.controller,
      @required this.prefixIcon,
      @required this.hintText,
      @required this.attribute,
      this.autofocus = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.initialValue = "",
      this.suffix,
      this.textCapitalization = TextCapitalization.words,
      this.focusNode,
      this.validators,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: attribute,
      focusNode: focusNode,
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      initialValue: initialValue,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:
            Icon(prefixIcon, color: Theme.of(context).primaryIconTheme.color),
        suffixIcon: suffix,
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      validators: validators == null ? [] : validators,
    );
  }
}
