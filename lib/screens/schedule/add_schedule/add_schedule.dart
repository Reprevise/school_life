import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_life/bloc/add_schedule_bloc.dart';
import 'package:school_life/components/forms/easy_form_bloc/easy_form_bloc.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:school_life/components/scroll_behavior/no_glow.dart';
import 'package:school_life/screens/schedule/add_schedule/widgets/schedule_field.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FormBlocHelper(
        create: (_) => AddScheduleFormBloc(),
        onSuccess: (_, __) {},
        onLoading: (_, __) {},
        onSubmitting: (_, __) {},
        builder: (context, state) {
          final formBloc = context.bloc<AddScheduleFormBloc>();
          return WillPopScope(
            onWillPop: () => formBloc.canPop(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/svg/add_schedule-shape.svg',
                      fit: BoxFit.fitHeight,
                      height: screenSize.height / 3.5,
                    ),
                    Positioned(
                      top: screenSize.height / 20,
                      child: Row(
                        children: <Widget>[
                          BackButton(),
                          const ScreenHeader('Add Schedule for...'),
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenSize.height / 9,
                      width: screenSize.width,
                      child: DropdownFieldBlocBuilder(
                        selectFieldBloc: formBloc.subjectField,
                        itemBuilder: (context, value) => value.name,
                        showEmptyItem: false,
                        padding: const EdgeInsets.all(16),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Subject',
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: _AddScheduleFormFields(formBloc)),
                Container(
                  width: double.infinity,
                  height: 75,
                  padding: const EdgeInsets.all(12),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.display2,
                    ),
                    color: Color(0xFF76B852),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AddScheduleFormFields extends StatelessWidget {
  final AddScheduleFormBloc formBloc;

  const _AddScheduleFormFields(this.formBloc);

  void submitData(Map<String, dynamic> data) {
    final days = data['days'] as List<String>;
    final startTime = data['startTime'] as TimeOfDay;
    final endTime = data['endTime'] as TimeOfDay;

    // formBloc.add
  }

  @override
  Widget build(BuildContext context) {
    void _openNewDaySheet() {
      Scaffold.of(context).showBottomSheet((context) {
        return ScheduleBottomSheet(
          formBloc: formBloc,
          onSaved: (data) {
            ExtendedNavigator.rootNavigator.pop();
            submitData(data);
          },
        );
      });
    }

    return BlocBuilder<ListFieldBloc<DayScheduleField>,
        ListFieldBlocState<DayScheduleField>>(
      bloc: formBloc.schedule,
      builder: (context, state) {
        if (state.fieldBlocs.isNotEmpty) {
          return ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.fieldBlocs.length,
                  itemBuilder: (_, indx) {
                    final field = state.fieldBlocs[indx];
                    return ScheduleField(
                      dayFieldBloc: field.day,
                      startTimeBloc: field.startTime,
                      endTimeBloc: field.endTime,
                      onRemove: () => formBloc.removeScheduleField(indx),
                    );
                  },
                  // separatorBuilder: (_, __) => const SizedBox(height: 5),
                ),
                OutlineButton(
                  onPressed: _openNewDaySheet,
                  color: Colors.black,
                  child: Text('Add day'),
                  textColor: Colors.black,
                ),
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('No schedule!'),
              SizedBox(
                width: 200,
                height: 75,
                child: OutlineButton(
                  onPressed: _openNewDaySheet,
                  color: Colors.black,
                  child: Text(
                    'Add day(s)',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class ScheduleBottomSheet extends StatefulWidget {
  final AddScheduleFormBloc formBloc;
  final void Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic> initialData;

  const ScheduleBottomSheet({
    @required this.formBloc,
    @required this.onSaved,
    this.initialData,
  });

  @override
  _ScheduleBottomSheetState createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final _selectedDays = <String>[];
  TimeOfDay _startTime;
  TimeOfDay _endTime;

  Map<String, dynamic> get _effectiveData => widget.initialData ?? {};

  List<String> get _effectiveDays => _effectiveData['days'] ?? _selectedDays;
  TimeOfDay get _effectiveStartTime =>
      _effectiveData['startTime'] ?? _startTime;
  TimeOfDay get _effectiveEndTime => _effectiveData['endTime'] ?? _endTime;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.75,
      minChildSize: 0.75,
      expand: false,
      initialChildSize: 0.75,
      builder: (context, _) {
        return Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 3,
                margin: const EdgeInsets.only(top: 15),
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFC0C0C0).withOpacity(0.50),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Text('Select day(s)',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(fontSize: 24.0, fontWeight: FontWeight.w600)),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.formBloc.availableDays.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final day = widget.formBloc.availableDays[index];
                return CheckboxListTile(
                  value: _effectiveDays.contains(day),
                  title: Text(day, style: TextStyle(fontSize: 16)),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (selected) {
                    if (selected) {
                      _effectiveDays.add(day);
                    } else {
                      _effectiveDays.remove(day);
                    }
                    setState(() {});
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      _effectiveStartTime?.format(context) ??
                          'Select start time',
                    ),
                    textColor: Colors.black,
                    onPressed: () async {
                      final result = await showTimePicker(
                        context: context,
                        initialTime: _effectiveStartTime ?? TimeOfDay.now(),
                      );
                      if (result == null) return;
                      _startTime = result;
                      setState(() {});
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      _effectiveEndTime?.format(context) ?? 'Select end time',
                    ),
                    textColor: Colors.black,
                    onPressed: () async {
                      final result = await showTimePicker(
                        context: context,
                        initialTime: _effectiveEndTime ?? TimeOfDay.now(),
                      );
                      if (result == null) return;
                      _endTime = result;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              height: 75,
              child: FlatButton(
                onPressed: () {
                  if (_startTime == null || _endTime == null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Must have start times!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    return;
                  }

                  final map = <String, dynamic>{};

                  map['startTime'] = _startTime;
                  map['endTime'] = _endTime;
                  map['days'] = _selectedDays;

                  widget.onSaved(map);
                },
                child: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: Colors.black),
                ),
                color: Color(0xFF82BD61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
