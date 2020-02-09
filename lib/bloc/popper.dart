import 'package:flutter/widgets.dart';
import 'package:school_life/components/dialog/dialogs.dart';

abstract class Popper {
  Future<bool> canPop(BuildContext context) async {
    if (fieldsAreEmpty()) {
      return true;
    }
    showOnPopDialog(context);
    return false;
  }
  bool fieldsAreEmpty();
}