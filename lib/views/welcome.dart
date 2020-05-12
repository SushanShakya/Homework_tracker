import 'package:flutter/material.dart';
import 'package:progress_tracker/bloc/welcome_bloc.dart';
import 'package:progress_tracker/views/widgets/mode_button.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose Mode', style: Theme.of(context).textTheme.display1,),
            ModeButton(
              text: "Student",
              image: 'student',
              onTap: () {
                appModeBloc.studentMode(context);
              },
            ),
            ModeButton(
              text: "Parent",
              image: "family",
              onTap: () {
                appModeBloc.parentMode(context);                
              },
            ),
          ],
        ),
      ),
    );
  }
}
