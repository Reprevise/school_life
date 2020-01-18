import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(
    this.subject, {
    Key key,
    this.isFirst,
    this.isLast,
  })  : assert(isFirst || isLast),
        super(key: key);

  final Subject subject;
  final bool isFirst;
  final bool isLast;

  BorderRadius getBorderRadius() {
    const Radius radius = Radius.circular(10);
    if (isFirst) {
      return const BorderRadius.only(topLeft: radius, topRight: radius);
    } else if (isLast) {
      return const BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: getBorderRadius(),
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFf77f3e),
                  Color(0xFFffb187),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: const Text('HI'),
            ),
          ),
        ],
      ),
    );
  }
}
