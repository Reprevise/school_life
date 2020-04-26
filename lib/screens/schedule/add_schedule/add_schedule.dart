import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_life/bloc/add_schedule_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8E8E8),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/add_schedule-shape.svg',
            fit: BoxFit.fitHeight,
            height: 300,
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    BackButton(),
                    ScreenHeader('Add Schedule for...'),
                  ],
                ),
                FormBlocHelper(
                  create: (_) => AddScheduleFormBloc(),
                  onSuccess: (_, __) {},
                  onLoading: (_, __) {},
                  onSubmitting: (_, __) {},
                  builder: (context, state) {
                    final formBloc = context.bloc<AddScheduleFormBloc>();
                    return WillPopScope(
                      onWillPop: () => formBloc.canPop(context),
                      child: _AddScheduleFormFields(formBloc),
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

class _AddScheduleFormFields extends StatelessWidget {
  final AddScheduleFormBloc formBloc;

  const _AddScheduleFormFields(this.formBloc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownFieldBlocBuilder(
          selectFieldBloc: formBloc.subjectField,
          itemBuilder: (context, value) => value.name,
          showEmptyItem: false,
          padding: const EdgeInsets.all(16),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            labelText: 'Subject',
            suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
