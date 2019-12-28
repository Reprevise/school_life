import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/models/subject.dart';

class SubjectItem extends StatelessWidget {
  final Subject subject;

  const SubjectItem(this.subject);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle bodyStyle = textTheme.body1.copyWith(color: Colors.black);

    Widget subjectName = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextOneLine(
        subject.name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: textTheme.display2.copyWith(color: Colors.black),
      ),
    );
    Widget roomText = RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Room: ",
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.room, style: bodyStyle)
        ],
      ),
    );
    Widget buildingText = RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Building: ",
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.building, style: bodyStyle)
        ],
      ),
    );
    Widget teacherText = RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Teacher: ",
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.teacher, style: bodyStyle)
        ],
      ),
    );
    Widget extraSubjectInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        roomText,
        Visibility(
          visible: subject.building.trim().isNotEmpty,
          child: buildingText,
        ),
        teacherText,
      ],
    );
    return Card(
      color: subject.color,
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: () => showDeleteSubjectDialog(context, subject),
        child: Container(
          height: 100,
          width: 375,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: subjectName,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: extraSubjectInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
