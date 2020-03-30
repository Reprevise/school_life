import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FieldBlocListBuilder<T extends GroupFieldBloc> extends StatelessWidget {
  final ListFieldBloc<T> fieldBlocList;
  final Widget Function(
    BuildContext context,
    ListFieldBloc<T> fieldBlocList,
    int index,
  ) itemBuilder;

  const FieldBlocListBuilder({
    @required this.fieldBlocList,
    @required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (fieldBlocList == null) {
      return SizedBox();
    } else {
      return ListView.builder(
        itemCount: fieldBlocList.value.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            itemBuilder(context, fieldBlocList, index),
      );
    }
  }
}
