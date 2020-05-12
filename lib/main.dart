import 'package:flutter/material.dart';
import 'package:progress_tracker/bloc/welcome_bloc.dart';
import 'package:progress_tracker/data/mode.dart';
import 'package:progress_tracker/views/home.dart';
import 'package:progress_tracker/views/welcome.dart';

void main() => runApp(ProgressTracker());

class ProgressTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Mode>(
        future: appModeBloc.currentAppMode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Mode mode = snapshot.data;
            return MaterialApp(
              title: "Progress Tracker",
              debugShowCheckedModeBanner: false,
              home: (mode == Mode.notSet)
                  ? Welcome()
                  : Home(
                      mode: mode,
                    ),
            );
          } else {
            return Container(
              color: Colors.white,
            );
          }
        });
  }
}
