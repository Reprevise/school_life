import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class AndroidDetails {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getCritDeviceData() async {
    Map<String, dynamic> critDeviceData;

    try {
      critDeviceData = _readCritAndroidData(await deviceInfoPlugin.androidInfo);
    } on PlatformException {
      critDeviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return critDeviceData;
  }

  Map<String, dynamic> _readCritAndroidData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.release': build.version.release,
      'version.sdkInt': build.version.sdkInt,
      'brand': build.brand,
      'manufacturer': build.manufacturer,
    };
  }
}
