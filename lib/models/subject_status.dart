import 'package:progress_tracker/data/constants.dart';

class Subject{
  String name;
  String _startTime;
  String _endTime;
  HomeworkStatus status;
  String id;

  DateTime get startTime {
    if(_startTime == ""){
      return null;
    }
    return DateTime.parse(_startTime);
  } 
  DateTime get endTime {
    if(_endTime == ""){
      return null;
    }
    return DateTime.parse(_endTime);
  } 

  // String get startTime => _startTime;
  // String get endTime => _endTime;

  set startTime(DateTime time) {
    if(time == null) {
      _startTime = "";
    }else{
      _startTime = time.toString();
    }
  }

  set endTime(DateTime time) {
    if( time == null) {
      _endTime = "";
    }else{
      _endTime = time.toString();
    }
  }

  Subject({this.name, this.status});
  Subject.withId({this.id,this.name,this.status});

  Subject.fromJson(Map<String, dynamic> data, String id)
      : name = data['Name'],
      _startTime = data['start_time'],
        _endTime = data['end_time'],
        status = _getStatus(data['status']),
        id = id;

  static HomeworkStatus _getStatus(String status) {
    switch(status) {
      case NOTDONE:
        return HomeworkStatus.notDone;
      case ONGOING:
        return HomeworkStatus.onGoing;
      case COMPLETED:
        return HomeworkStatus.completed;
      default:
        return HomeworkStatus.notDone;
    }
  }

  static String _currentStatus(status) {
    switch(status){
      case HomeworkStatus.notDone:
        return NOTDONE;
      case HomeworkStatus.onGoing:
        return ONGOING;
      case HomeworkStatus.completed:
        return COMPLETED;
      default:
        return NOTDONE;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "start_time": _startTime,
      "end_time": _endTime,
      "status": _currentStatus(status),
      "Name" : name
    };
  }
}
