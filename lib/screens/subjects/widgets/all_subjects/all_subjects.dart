import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:school_life/util/models/subject.dart';

class AllSubjects extends StatefulWidget {
  final Future<List<Subject>> future;
  final Function deleteSubject;

  AllSubjects(this.future, this.deleteSubject);

  @override
  State<StatefulWidget> createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;

    return FutureBuilder<List<Subject>>(
      future: widget.future,
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
                        deleteSubject: widget.deleteSubject,
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
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli"),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli"),
          ),
          TextSpan(text: subject.building)
        ],
      ),
    );
  }

  Widget buildTeachInfo(Subject subject) {
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

  void _handleDeleteSubject(BuildContext context, Subject subject) {
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
        style: TextStyle(
          fontSize: 24.0,
          fontFamily: "Muli",
          fontWeight: FontWeight.bold,
          color: useWhiteForeground(Color(subject.colorValue))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
      ),
    ));
    Widget subLocInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildRoomInfo(subject),
        Visibility(
          visible: subject.building.trim().isNotEmpty,
          child: buildBuildingInfo(subject),
        ),
        buildTeachInfo(subject)
      ],
    );
    return Card(
      color: Color(subject.colorValue),
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: () => _handleDeleteSubject(context, subject),
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
