import 'dart:io';

import 'package:flutter/material.dart';

const String SUBJECTSCOLLECTION = 'Subjects';
const String NOTDONE = 'Not Done';
const String ONGOING = 'Ongoing';
const String COMPLETED = 'Completed';
const String LASTUPDATEDCOLECTION = "Last Updated";
const String DEVICETOKENCOLLECTION = "Device Tokens";
const String STUDENTDEVICECOLLECTION = "Student Devices";

const String MODEKEY = "Mode";
const String ISREGISTEREDKEY = "Registration";

const String STUDENT = 'Student';
const String PARENT = "Parent";

const String LASTUPDATEDDOCUMENT = 'ZgEIOYtFla5KS9AlGmid';

String convertDate(DateTime startTime) {
  return "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}";
}

enum HomeworkStatus { notDone, onGoing, completed }

TextStyle get style => TextStyle(color: Colors.white, fontSize: 18.0);

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
    return false;
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
}
