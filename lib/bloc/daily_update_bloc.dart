import 'package:intl/intl.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/models/last_updated.dart';
import 'package:progress_tracker/models/subject_status.dart';
import 'package:progress_tracker/services/firestore_service.dart';

class DailyUpdateCheckerBloc {
  static Future<bool> isUpdated() async {
    LastUpdated date = await FirestoreService().getLastUpdatedDate();
    DateTime now = DateTime.now();
    if (date.lastUpdated == DateFormat('yyyy-MM-dd').format(now)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> update() async {
    if (await checkInternetConnection()) {
      if (!await isUpdated()) {
        print("Updating");
        FirestoreService().updateLastUpdated();

        List<Subject> subjects = await FirestoreService().getCurrentSubjects();
        List<Subject> updatedSubjects = subjects.map((subject) {
          subject.startTime = null;
          subject.endTime = null;
          subject.status = HomeworkStatus.notDone;
          return subject;
        }).toList();

        for (int i = 0; i < updatedSubjects.length; i++) {
          await FirestoreService().updateSubjectStatus(updatedSubjects[i]);
        }
      }
      return true; 
    }else{
      return false;
    }
  }
}
