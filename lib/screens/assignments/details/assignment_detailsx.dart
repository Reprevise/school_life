import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/components/appbar/details_page_appbar.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/util/color_utils.dart';

class AssignmentDetailsPageX extends StatelessWidget {
  final Assignment assignment;

  const AssignmentDetailsPageX(this.assignment);

  Color getTextColorFromBackground(Color backgroundColor) {
    return useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color lightAccent = assignment.color.getLighterAccent();
    Color darkAccent = assignment.color.getDarkerAccent();

    return Scaffold(

      backgroundColor: Colors.lightGreen,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            DetailsPageAppbar(assignment.name, Colors.lightGreen)
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: ListView.builder(
            itemExtent: 50.0,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              );
            },
          ),
        ),
      ),
    );

    // return Scaffold(
    //   // backgroundColor: lightAccent,
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverAppBar(
    //         floating: false,
    //         pinned: true,
    //         snap: false,
    //         elevation: 0,
    //         expandedHeight: 150.0,
    //         brightness: DynamicTheme.of(context).brightness,
    //         // title: Text(assignment.name),
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: Text(assignment.name),
    //         ),
    //       ),
    //       SliverFillRemaining(
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(36),
    //               topRight: Radius.circular(36),
    //             ),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: ListView.builder(
    //               itemExtent: 50.0,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Container(
    //                   alignment: Alignment.center,
    //                   color: Colors.lightBlue[100 * (index % 9)],
    //                   child: Text('List Item $index'),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
