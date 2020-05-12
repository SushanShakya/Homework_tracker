import 'package:progress_tracker/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Mode {
  student, parent, notSet
}

class AppMode {

  static Future<Mode> mode() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String data = _prefs.getString(MODEKEY);

    return _getRealMode(data??"Not Set");
  }

  static Mode _getRealMode(String mode) {
    switch(mode){
      case STUDENT:
        return Mode.student;
      case PARENT:
        return Mode.parent;
      default:
        return Mode.notSet;
    }
  }

  static saveMode(Mode mode) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString(MODEKEY, _getStringMode(mode));
  }

  static String _getStringMode(Mode mode) {
    switch(mode){
      case Mode.student:
        return STUDENT;
      case Mode.parent:
        return PARENT;
      default:
        return PARENT;
    }
  }
}