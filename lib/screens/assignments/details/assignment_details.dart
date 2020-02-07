import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/scroll_behavior/no_glow.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/util/color_utils.dart';

class AssignmentDetailsPage extends StatelessWidget {
  const AssignmentDetailsPage(this.assignment);

  final Assignment assignment;

  Color getTextColorFromBackground(Color backgroundColor) {
    return useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color lightAccent = assignment.color.getLighterAccent();
    final Color darkAccent = assignment.color.getDarkerAccent();

    return Scaffold(
      backgroundColor: lightAccent,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[DetailsPageAppbar(assignment.name, lightAccent)];
        },
        body: Container(
          decoration: BoxDecoration(
            color: assignment.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: assignment.details.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Details',
                              style: textTheme.headline3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: darkAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              assignment.details,
                              style: textTheme.bodyText2.copyWith(
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
      ),
    );

    // return Scaffold(
    //   backgroundColor: lightAccent,
    //   appBar: CustomAppBar(
    //     '',
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       SafeArea(
    //         top: true,
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Container(
    //             child: Text(
    //               assignment.name,
    //               style: textTheme.display3.copyWith(
    //                 color: getTextColorFromBackground(lightAccent),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 36),
    //       Expanded(
    //         child: Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: assignment.color,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(36),
    //               topRight: Radius.circular(36),
    //             ),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Visibility(
    //                     visible: assignment.details.isNotEmpty,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 16.0),
    //                           child: Text(
    //                             'Details',
    //                             style: textTheme.display2,
    //                           ),
    //                         ),
    //                         SizedBox(height: 8),
    //                         Container(
    //                           padding: const EdgeInsets.all(12),
    //                           width: double.infinity,
    //                           decoration: BoxDecoration(
    //                             color: darkAccent,
    //                             borderRadius: BorderRadius.circular(16),
    //                           ),
    //                           child: Text(
    //                             assignment.details,
    //                             style: textTheme.body1.copyWith(
    //                               color: getTextColorFromBackground(darkAccent),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
