import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';

typedef Create<C> = C Function(BuildContext);
typedef Success = void Function(BuildContext, FormBlocSuccess<String, String>);
typedef Loading = void Function(BuildContext, FormBlocLoading<String, String>);
typedef Submitting = void Function(
    BuildContext, FormBlocSubmitting<String, String>);
typedef BBuilder = Widget Function(BuildContext, FormBlocState<String, String>);

class FormBlocHelper<T extends FormBloc<String, String>>
    extends StatelessWidget {
  const FormBlocHelper({
    @required this.create,
    @required this.onSuccess,
    @required this.onLoading,
    @required this.onSubmitting,
    @required this.builder,
  });

  final Create<T> create;
  final Success onSuccess;
  final Loading onLoading;
  final Submitting onSubmitting;
  final BBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: Builder(
        builder: (context) {
          return FormBlocListener<T, String, String>(
            onSuccess: onSuccess,
            onLoading: onLoading,
            onSubmitting: onSubmitting,
            child:
                BlocBuilder<T, FormBlocState<String, String>>(builder: builder),
          );
        },
      ),
    );
  }
}
