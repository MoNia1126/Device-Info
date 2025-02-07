import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  Future<Map<String, String>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Map<String, String> deviceData = {};

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceData['model'] = androidInfo.model;
        deviceData['osVersion'] = androidInfo.version.release;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceData['model'] = iosInfo.model;
        deviceData['osVersion'] = iosInfo.systemVersion;
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }

    return deviceData;
  }
}
