import 'package:flutter/material.dart';
import 'package:progress_tracker/data/constants.dart';

class StatusIcon extends StatelessWidget {
  final HomeworkStatus status;

  StatusIcon({@required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == HomeworkStatus.notDone) {
      return Icon(Icons.clear, color: Colors.red,);
    }else if(status == HomeworkStatus.onGoing){
      return Icon(Icons.history, color: Colors.amber,);
    }else{
      return Icon(Icons.done, color: Colors.green,);
    }
  }
}
