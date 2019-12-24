import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:school_life/main.dart';

class AndroidDetails {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = {};

  AndroidDetails() {
    _init().then((_) => getIt.signalReady(this));
  }

  Future<void> _init() async {
    try {
      AndroidDeviceInfo _deviceInfo = await _deviceInfoPlugin.androidInfo;
      _deviceData = _getDeviceData(_deviceInfo);
    } on PlatformException {
      _deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.',
      };
    }
  }

  Map<String, dynamic> _getDeviceData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
    };
  }

  // android 5
  bool canChangeStatusBarColor() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 21;
    }
    return null;
  }

  bool canChangeNavbarIconColor() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 27;
    }
    return null;
  }
}
