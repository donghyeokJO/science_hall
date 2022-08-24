import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final beaconPermissionProvider = FutureProvider<bool>((ref) async {
  if (Platform.isIOS){
    await [Permission.bluetoothScan,Permission.location].request();
    return await Permission.bluetoothScan.isGranted && await Permission.location.isGranted;
  }else{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid && androidInfo.version.sdkInt! <= 30) {
      var requestStatus = await Permission.location.request();
      return requestStatus.isGranted || requestStatus.isLimited;
    } else {
      await [Permission.bluetoothScan,Permission.bluetoothConnect,Permission.location].request();
      return await Permission.bluetoothScan.isGranted && await Permission.location.isGranted && await Permission.bluetoothConnect.isGranted;
    }
  }
});