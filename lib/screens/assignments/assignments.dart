import 'package:flutter/material.dart';
import 'package:school_life/components/dialogs/dialogs.dart';
import 'package:school_life/components/navbar/navbar.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/main.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/assignments/widgets/assignments_list.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsPage extends StatefulWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  AssignmentsPage(this.tabsChangeNotifier);

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  SubjectsRepository subjects;
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    subjects = sl<SubjectsRepository>();
    _doesUserHaveSubjects();
  }

  void _doesUserHaveSubjects() {
    final allSubjects = subjects.subjects;
    if (allSubjects.isNotEmpty) {
      _userHasSubjects = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CustomBottomNavBar(widget.tabsChangeNotifier),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddAssignmentPress,
        label: Text(
          'Create',
          style: Theme.of(context).accentTextTheme.bodyText1,
        ),
        icon: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          primary: false,
          children: <Widget>[
            ScreenHeader('Assignments'),
            Center(
              child: AssignmentsList(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddAssignmentPress() {
    if (!_userHasSubjects) {
      showNoSubjectsDialog(context);
      return;
    }
    Router.navigator.pushNamed(Routes.addAssignment);
  }
}
