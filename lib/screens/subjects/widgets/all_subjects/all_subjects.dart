import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/models/subject.dart';

class AllSubjects extends StatelessWidget {
  final Future<List<Subject>> future;
  final Function deleteSubject;

  const AllSubjects(this.future, this.deleteSubject);

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;

    return FutureBuilder<List<Subject>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data.isEmpty) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.school,
                  color: Colors.grey[400],
                  size: 128.0,
                ),
                Text(
                  "You don't have any subjects!",
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Click the button below to add some!",
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: fontSize / 1.2),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return Column(
            children: snapshot.data
                .map((subject) => SubjectItem(subject, deleteSubject))
                .toList(),
          );
        }
      },
    );
  }
}

class SubjectItem extends StatelessWidget {
  final Subject subject;
  final Function deleteSubject;

  const SubjectItem(this.subject, this.deleteSubject);

  void _showDeleteSubjectDialog(BuildContext context, Subject subject) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).dialogTheme.titleTextStyle.color,
                fontSize: 16,
              ),
              children: <TextSpan>[
                TextSpan(text: "Do you want to delete "),
                TextSpan(
                  text: "${subject.name}?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle.color,
                ),
              ),
              onPressed: () {
                deleteSubject(subject);
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle.color,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle bodyStyle = textTheme.body1.copyWith(color: Colors.black);

    Widget subjectName = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        subject.name,
        overflow: TextOverflow.clip,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: textTheme.display3.copyWith(color: Colors.black),
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
            style: GoogleFonts.muli(fontWeight: FontWeight.bold),
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
            style: GoogleFonts.muli(fontWeight: FontWeight.bold),
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
            style: TextStyle(fontWeight: FontWeight.bold),
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
      color: Color(subject.colorValue),
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: () => _showDeleteSubjectDialog(context, subject),
        child: Container(
          height: 100,
          width: 375,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[subjectName],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[extraSubjectInfo],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
