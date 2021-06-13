import 'package:flutter/material.dart';

import '../../../models/subject.dart';
import '../../../util/color_utils.dart';

class SubjectDetailsPage extends StatelessWidget {
  const SubjectDetailsPage(this.subject);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lightAccent = ColorUtils.getLighterAccent(subject.color);
    //! will be used later
    // final Color darkAccent = subject.color.getDarkerAccent();

    return Scaffold(
      backgroundColor: lightAccent,
      extendBodyBehindAppBar: true,
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
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: subject.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Schedule',
                      style: textTheme.headline3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // TODO: implement schedule section
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
