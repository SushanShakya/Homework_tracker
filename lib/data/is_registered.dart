import 'package:progress_tracker/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRegistrationChecker {
  static DeviceRegistrationChecker _checker ;

  factory DeviceRegistrationChecker() {
    if (_checker == null) {
      _checker = DeviceRegistrationChecker._instance();
    }
    
    return _checker;
  }

  DeviceRegistrationChecker._instance();

  Future<bool> isRegistered() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    bool value = _prefs.getBool(ISREGISTEREDKEY);
    print(value);
    return value??false;
  }

  Future<bool> registerDevice(bool value) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return await _prefs.setBool(ISREGISTEREDKEY, value);
  }

}