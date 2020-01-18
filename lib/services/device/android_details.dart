import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

abstract class AndroidDetails {
  Map<String, dynamic> getDeviceData(AndroidDeviceInfo build);

  bool canChangeStatusBarColor();

  bool canChangeNavbarIconColor();
}

class AndroidDetailsImplementation implements AndroidDetails {
  AndroidDetailsImplementation(Completer<dynamic> completer) {
    _init(completer);
  }

  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<void> _init(Completer<dynamic> completer) async {
    try {
      final AndroidDeviceInfo _deviceInfo =
          await DeviceInfoPlugin().androidInfo;
      _deviceData = getDeviceData(_deviceInfo);
    } on PlatformException {
      _deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.',
      };
    }
    completer.complete();
  }

  @override
  Map<String, dynamic> getDeviceData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
    };
  }

  // android 5
  @override
  bool canChangeStatusBarColor() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 21 as bool;
    }
    return null;
  }

  @override
  bool canChangeNavbarIconColor() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 27 as bool;
    }
    return null;
  }
}
