import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/navbar.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/subjects/widgets/subjects_list.dart';

class SubjectsPage extends StatelessWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  SubjectsPage(this.tabsChangeNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(tabsChangeNotifier),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Router.navigator.pushNamed(Routes.addSubject),
        label: Text(
          'Create',
          style: Theme.of(context).accentTextTheme.bodyText1,
        ),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: <Widget>[
          ScreenHeader('Subjects'),
          SubjectsList(),
        ],
      ),
    );
  }
}
