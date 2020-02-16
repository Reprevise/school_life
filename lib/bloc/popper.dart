import 'package:flutter/widgets.dart';
import 'package:school_life/components/dialogs/dialogs.dart';

mixin Popper {
  Future<bool> canPop(BuildContext context) async {
    if (fieldsAreEmpty()) {
      return true;
    }
    showOnPopDialog(context);
    return false;
  }
  bool fieldsAreEmpty();
}