import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/data/is_registered.dart';

import 'package:progress_tracker/data/mode.dart';
import 'package:progress_tracker/services/firestore_service.dart';

class PushNotificationService {
  static PushNotificationService _notificationservice;

  factory PushNotificationService() {
    if (_notificationservice == null) {
      _notificationservice = PushNotificationService._instance();
    }

    return _notificationservice;
  }

  PushNotificationService._instance();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirestoreService _firestoreService = FirestoreService();
  final DeviceRegistrationChecker _checker = DeviceRegistrationChecker();

  Future<String> _getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<bool> activateNotification(Mode mode) async {
    if (await checkInternetConnection()) {
      if (mode == Mode.parent) {
        bool isRegistered = await _checker.isRegistered();
        if (!isRegistered) {
          List<String> _devices = await _firestoreService.getDevicesList();
          String token = await _getDeviceToken();

          if (!_devices.contains(token)) {
            await _firestoreService.addNewdevice(token);
            _checker.registerDevice(true);
          }
        }
      }
      return true;
    }else{
      return false;
    }
  }
}
