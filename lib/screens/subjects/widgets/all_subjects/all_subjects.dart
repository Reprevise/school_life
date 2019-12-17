import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/models/subject.dart';

class AllSubjects extends StatelessWidget {
  final Future<List<Subject>> future;
  final Function deleteSubject;

  AllSubjects(this.future, this.deleteSubject);

  @override
  Widget build(BuildContext context) {
    print("all subjects rebuilding");
    final fontSize = MediaQuery.of(context).size.width / 20;

    return FutureBuilder<List<Subject>>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.data.length > 0) {
              return Column(
                children: snapshot.data
                    .map(
                      (subject) => SubjectItem(
                        subject: subject,
                        deleteSubject: deleteSubject,
                      ),
                    )
                    .toList(),
              );
            } else {
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
                  )
                ],
              );
            }
        }
      },
    );
  }
}

class SubjectItem extends StatelessWidget {
  final Subject subject;
  final Function deleteSubject;

  SubjectItem({@required this.subject, @required this.deleteSubject});

  Widget buildRoomInfo(Subject subject) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: useWhiteForeground(Color(subject.colorValue))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Room: ",
            style: GoogleFonts.muli(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: subject.room)
        ],
      ),
    );
  }

  Widget buildBuildingInfo(Subject subject) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: useWhiteForeground(Color(subject.colorValue))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Building: ",
            style: GoogleFonts.muli(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: subject.building)
        ],
      ),
    );
  }

  Widget buildTeacherInfo(Subject subject) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: useWhiteForeground(Color(subject.colorValue))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Teacher: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: subject.teacher)
        ],
      ),
    );
  }

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
    Widget subName = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          subject.name,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: Theme.of(context).textTheme.display3,
        ),
      ),
    );
    Widget subLocInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildRoomInfo(subject),
        Visibility(
          visible: subject.building.trim().isNotEmpty,
          child: buildBuildingInfo(subject),
        ),
        buildTeacherInfo(subject)
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
                  children: <Widget>[subName],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[subLocInfo],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
