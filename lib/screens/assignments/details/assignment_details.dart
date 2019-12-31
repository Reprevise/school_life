import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/util/color_utils.dart';

class AssignmentDetailsPage extends StatelessWidget {
  final Assignment assignment;

  const AssignmentDetailsPage(this.assignment);

  Color getTextColorFromBackground(Color backgroundColor) {
    return useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color lightAccent = assignment.color.getLighterAccent();
    Color darkAccent = assignment.color.getDarkerAccent();

    return Scaffold(
      backgroundColor: lightAccent,
      appBar: CustomAppBar(
        "",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Text(
                  assignment.name,
                  style: textTheme.display3.copyWith(
                    color: getTextColorFromBackground(lightAccent),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 36),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: assignment.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Visibility(
                        visible: assignment.details.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Details",
                                style: textTheme.display2,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: darkAccent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                assignment.details,
                                style: textTheme.body1.copyWith(
                                  color: getTextColorFromBackground(darkAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
