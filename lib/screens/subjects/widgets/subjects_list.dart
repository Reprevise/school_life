import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/subjects/widgets/subject_item.dart';

class SubjectsList extends StatelessWidget {
  final Future<List<Subject>> future;
  final Function deleteSubject;

  const SubjectsList(this.future, this.deleteSubject);

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
