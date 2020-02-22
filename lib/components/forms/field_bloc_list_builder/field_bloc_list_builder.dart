import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';

class FieldBlocListBuilder extends StatelessWidget {
  final FieldBlocList fieldBlocList;
  final Widget Function(
    BuildContext context,
    FieldBlocList fieldBlocList,
    int index,
  ) itemBuilder;

  const FieldBlocListBuilder({
    Key key,
    @required this.fieldBlocList,
    @required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (fieldBlocList == null) {
      return Container();
    } else {
      return ListView.builder(
        itemCount: fieldBlocList.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            itemBuilder(context, fieldBlocList, index),
      );
    }
  }
}
