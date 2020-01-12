import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/models/subject.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem(this.subject);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle bodyStyle = textTheme.body1.copyWith(color: Colors.black);

    final Widget subjectName = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextOneLine(
        subject.name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: textTheme.display2.copyWith(color: Colors.black),
      ),
    );
    final Widget roomText = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Room: ',
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.room, style: bodyStyle)
        ],
      ),
    );
    final Widget buildingText = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Building: ',
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.building, style: bodyStyle)
        ],
      ),
    );
    final Widget teacherText = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Teacher: ',
            style: Theme.of(context).textTheme.body2,
          ),
          TextSpan(text: subject.teacher, style: bodyStyle)
        ],
      ),
    );
    final Widget extraSubjectInfo = Column(
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
