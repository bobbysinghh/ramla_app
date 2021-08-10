import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceIdentifier() async {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor;
  } else if (Platform.isLinux) {
    LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
    deviceIdentifier = linuxInfo.machineId;
  }
  return deviceIdentifier;
}

class Config {
  static String name = "";
  static String email = "";
  static String mobile = "";
  static String fcmToken = "";
  static String userId = "";
  static String deviceID = "";
  // getDeviceIdentifier().then((value) {
  //   deviceID = value;

  // });
}
