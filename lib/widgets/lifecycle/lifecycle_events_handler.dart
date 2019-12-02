import 'package:flutter/widgets.dart';
import 'package:school_life/services/theme_service.dart';

class LifecycleEventsHandler extends StatelessWidget
    with WidgetsBindingObserver {
  const LifecycleEventsHandler({this.resumeCallback, this.child});

  final Function resumeCallback;
  final Widget child;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) resumeCallback();
  }

  @override
  Widget build(BuildContext context) {
    ThemeService().updateColors();
    return child;
  }
}
