import 'package:flutter/material.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/models/subject_status.dart';

class StatusBloc {

  String _checkDifference(DateTime startTime,DateTime endTime) {
    int minutes = endTime.difference(startTime).inMinutes;

    int hours = minutes ~/60;
    minutes %= 60;

    return hours == 0 ?"$minutes minutes":"$hours hours and $minutes minutes";

  }



  showStatus(BuildContext context,Subject data) {
    if (data.status == HomeworkStatus.notDone) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        "${data.name} homework not started yet",
        style: style,
      )));
    } else if (data.status == HomeworkStatus.onGoing) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        "Started ${data.name} homework ${_checkDifference(data.startTime, DateTime.now())} ago",
        style: style,
      )));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        "${data.name } homework completed in ${_checkDifference(data.startTime,data.endTime)}",
        style: style,
      )));
    }
  }

  
}

final StatusBloc statusBloc = StatusBloc();