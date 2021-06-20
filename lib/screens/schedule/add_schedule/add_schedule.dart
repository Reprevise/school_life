import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../../../components/forms/form_spacer.dart';
import '../../../components/screen_header/screen_header.dart';
import 'add_schedule_viewmodel.dart';
import 'widgets/schedule_field.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ViewModelBuilder<AddScheduleViewModel>.reactive(
        viewModelBuilder: () => AddScheduleViewModel(),
        onModelReady: (model) => model.initialize(),
        fireOnModelReadyOnce: true,
        builder: (context, model, _) {
          return ReactiveForm(
            formGroup: model.form,
            onWillPop: model.canPop,
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
                      top: screenSize.height / 40,
                      child: Row(
                        children: const <Widget>[
                          BackButton(),
                          ScreenHeader('Add Schedule for...'),
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenSize.height / 9,
                      width: screenSize.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ReactiveDropdownField(
                          items: model.subjects
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          formControl: model.subject,
                          hint: const Text('Select subject'),
                          dropdownColor: Colors.white,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: _AddScheduleFormFields(model)),
                Container(
                  width: double.infinity,
                  height: 75,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextButton(
                    onPressed: model.addSchedule,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF76B852),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.raleway(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
  final AddScheduleViewModel model;

  const _AddScheduleFormFields(this.model);

  @override
  Widget build(BuildContext context) {
    if (model.scheduleItems.value!.isNotEmpty) {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: model.scheduleItems.value!.length,
            itemBuilder: (_, indx) {
              final tBlock = model.scheduleItems.value![indx];
              return ScheduleField(
                tBlock: tBlock!,
                onRemove: () => model.removeTimeBlock(indx),
                onEdit: () => model.openScheduleSheet(tBlock, indx),
              );
            },
            separatorBuilder: (_, __) => const FormSpacer(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 100,
            child: OutlinedButton(
              onPressed: () => model.openScheduleSheet(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.grey, width: 3),
              ),
              child: Text(
                'Add day',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text('No schedule!'),
          OutlinedButton(
            onPressed: () => model.openScheduleSheet(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              side: const BorderSide(color: Colors.grey, width: 3),
            ),
            child: Text(
              'Add day',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      );
    }
  }
}
