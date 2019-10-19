import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

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
  void didUpdateWidget(SubjectsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    await RepositoryServiceSubject.deleteSubject(subject);
    setState(() {
      future = RepositoryServiceSubject.getAllSubjects();
    });
  }

  Color processColor(String color) {
    String valueString = color.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  refreshSubjects() {
    setState(() {
      future = RepositoryServiceSubject.getAllSubjects();
    });
  }

  Card buildItem(Subject subject) {
    Widget subName = Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        subject.name,
        style: TextStyle(
          fontSize: 24.0,
          color: useWhiteForeground(processColor(subject.color))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
      ),
    );
    Widget subLocInfo = Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            // visible: subject.room.trim().isNotEmpty,
            child: buildRoomInfo(subject),
          ),
          Visibility(
            // visible: subject.building.trim().isNotEmpty,
            child: buildBuildingInfo(subject),
          )
        ],
      ),
    );
    Widget subTeachInfo = Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            child: buildTeachInfo(subject),
          )
        ],
      ),
    );
    return Card(
      color: processColor(subject.color),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[subName],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  children: <Widget>[subLocInfo],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[subTeachInfo],
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
          color: useWhiteForeground(processColor(subject.color))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Room: ",
            style: TextStyle(fontWeight: FontWeight.bold),
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
          color: useWhiteForeground(processColor(subject.color))
              ? Color(0xffffffff)
              : Color(0xff000000),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Building: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: subject.building)
        ],
      ),
    );
  }

  Widget buildTeachInfo(Subject subject) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        style: TextStyle(
          color: useWhiteForeground(processColor(subject.color))
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

  @override
  Widget build(BuildContext context) {
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

    _navigateToAddSubject(BuildContext context) async {
      Navigator.pushNamed(context, '/subjects/add-subject');
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Subjects"),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 2.0,
        onPressed: () {
          _navigateToAddSubject(context);
        },
        label: Text("Add Subject"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        primary: false,
        padding: EdgeInsets.only(top: 20, bottom: 70),
        children: <Widget>[
          buildSubjectFuture(),
        ],
      ),
    );
  }
}
