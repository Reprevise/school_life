import 'package:flutter/widgets.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({this.resumeCallBack});

  final Function resumeCallBack;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      resumeCallBack();
      return;
    }
  }
}
