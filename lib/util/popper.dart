import 'package:pedantic/pedantic.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../services/stacked/dialogs.dart';

abstract class Popper {
  final ds = locator<DialogService>();

  Future<bool> canPop() async {
    if (fieldsAreEmpty()) {
      return true;
    }
    unawaited(ds.showCustomDialog(variant: DialogType.pop));
    return false;
  }

  bool fieldsAreEmpty();
}
