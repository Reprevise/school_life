import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/util/color_utils.dart';

class SubjectDetailsPage extends StatelessWidget {
  final Subject subject;

  const SubjectDetailsPage(this.subject);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color lightAccent = subject.color.getLighterAccent();
    Color darkAccent = subject.color.getDarkerAccent();

    return Scaffold(
      backgroundColor: lightAccent,
      appBar: CustomAppBar(""),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Text(
                  subject.name,
                  style: Theme.of(context).textTheme.display3,
                ),
              ),
            ),
          ),
          SizedBox(height: 36),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: subject.color,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Schedule",
                          style: textTheme.display2,
                        ),
                      ),
                      SizedBox(height: 8),
//                      Container(
//                        padding: EdgeInsets.all(12),
//                        width: double.infinity,
//                        decoration: BoxDecoration(
//                          color: darkAccent,
//                          borderRadius: BorderRadius.circular(16),
//                        ),
//                        child: Text(
//                          assignment.details,
//                          style: textTheme.body1.copyWith(
//                              color: useWhiteForeground(darkAccent)
//                                  ? Colors.white
//                                  : Colors.black),
//                        ),
//                      )
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
