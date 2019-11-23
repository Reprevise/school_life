import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:school_life/screens/forms/add_subject/add_subject.dart';
import 'package:school_life/screens/settings/children/subjects-set.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Future<List<Subject>> future;

  @override
  void initState() {
    refreshSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Subjects",
      appBarActions: <Widget>[
        PopupMenuButton(
          onSelected: (_) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectsSettingsPage(),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Settings"),
                value: "Settings",
              ),
            ];
          },
        ),
      ],
      fab: FloatingActionButton.extended(
        onPressed: () {
          future.then((subjectList) {
            if (subjectList.length >= 19) {
              _showTooManySubjectsDialog();
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSubjectPage(),
              ),
            );
          });
        },
        label: Text(
          "Add Subject",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        icon: Icon(Icons.add),
      ),
      fabLocation: FloatingActionButtonLocation.centerFloat,
      scaffoldBody: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: buildSubjectFuture(),
        ),
      ),
    );
  }

  void _showTooManySubjectsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Too many subjects",
            style: Theme.of(context).textTheme.display2,
          ),
          content: Text(
            "You have 19 subjects, that's a lot! \nUnfortunately, we don't support more than 19 subjects. :( \nHowever, we will in the future, stay tuned!",
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Aw :("),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
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
                    ))
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

  deleteSubject(Subject subject) async {
    await subject.delete();
    refreshSubjects();
  }

  refreshSubjects() {
    setState(() {
      future = RepositoryServiceSubject.getAllSubjects();
    });
  }

  Card buildItem(Subject subject) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Widget buildSubjectFuture() {
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
                      (subject) => buildItem(subject),
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
                    style: Theme.of(context).textTheme.display2,
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
                        .copyWith(fontSize: 18),
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
