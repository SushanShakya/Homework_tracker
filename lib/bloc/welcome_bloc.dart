import 'package:flutter/material.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/data/mode.dart';
import 'package:progress_tracker/views/home.dart';

class AppModeBloc {
  studentMode(BuildContext context) async {
    if (await checkInternetConnection()) {
      await AppMode.saveMode(Mode.student);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(mode: Mode.student)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoInternetView()));
    }
  }

  parentMode(BuildContext context) async {
    if (await checkInternetConnection()) {
      await AppMode.saveMode(Mode.parent);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(mode: Mode.parent)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoInternetView()));
    }
  }

  Future<Mode> currentAppMode() {
    return AppMode.mode();
  }
}

final AppModeBloc appModeBloc = AppModeBloc();
