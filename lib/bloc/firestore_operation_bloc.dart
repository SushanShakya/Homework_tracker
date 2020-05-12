import 'package:flutter/material.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/models/subject_status.dart';
import 'package:progress_tracker/services/firestore_service.dart';

class SubjectsCrudBloc with ChangeNotifier {
  FirestoreService _firestoreService = FirestoreService();

  start(Subject subject) async {
    DateTime now = DateTime.now();
    // String currentTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    subject.startTime = now;
    subject.status = HomeworkStatus.onGoing;

    await _firestoreService.updateSubjectStatus(subject);
  }

  end(Subject subject) async {
    DateTime now = DateTime.now();
    // String currentTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    subject.endTime = now;
    subject.status = HomeworkStatus.completed;

    await _firestoreService.updateSubjectStatus(subject);
  }

  updateHomeworkStatus(Subject subject, BuildContext context) async {
    if (subject.status == HomeworkStatus.notDone) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        "Started doing ${subject.name} Homework",
        style: _style,
      )));
      await start(subject);
    } else if (subject.status == HomeworkStatus.onGoing) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        " Completed ${subject.name} Homework",
        style: _style,
      )));
      await end(subject);
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        "${subject.name} Homework is Already Completed",
        style: _style,
      )));
    }
  }

  TextStyle get _style => TextStyle(color: Colors.white, fontSize: 18.0);

}
