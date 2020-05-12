import 'package:flutter/material.dart';
import 'package:progress_tracker/bloc/daily_update_bloc.dart';
import 'package:progress_tracker/bloc/firestore_operation_bloc.dart';
import 'package:progress_tracker/bloc/status_bloc.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/data/mode.dart';
import 'package:progress_tracker/models/subject_status.dart';
import 'package:progress_tracker/services/firestore_service.dart';
import 'package:progress_tracker/services/push_notification.dart';
import 'package:progress_tracker/views/widgets/status_icon.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final Mode mode;

  Home({@required this.mode});

  final PushNotificationService _pushNotificationService =
      PushNotificationService();

  @override
  Widget build(BuildContext context) { 
    return ChangeNotifierProvider<SubjectsCrudBloc>(
      create: (context) => SubjectsCrudBloc(),
      child: FutureBuilder(
          future: _pushNotificationService.activateNotification(mode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: DailyUpdateCheckerBloc.update(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("Homeworks"),
                          centerTitle: true,
                          // backgroundColor: Colors.transparent,
                          elevation: 1.0,
                        ),
                        body: StreamBuilder<List<Subject>>(
                          stream: FirestoreService().getSubjects(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Something Went Wrong"),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            List<Subject> data = snapshot.data;

                            return ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Consumer<SubjectsCrudBloc>(
                                    builder: (context, bloc, child) {
                                      return ListItem(
                                        bloc: bloc,
                                        data: data[index],
                                        mode: mode,
                                      );
                                    },
                                  );
                                });
                          },
                        ),
                      );
                    } else {
                      return Scaffold(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Checking Homeworks...",
                              style: Theme.of(context).textTheme.title,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: LinearProgressIndicator(),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  });
            } else {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "We are setting up some stuff",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: LinearProgressIndicator(),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/no_internet.png",
              width: width / 2,
            ),
            Text(
              "No internet Connection",
              style: Theme.of(context).textTheme.headline,
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Mode mode;
  final SubjectsCrudBloc bloc;
  final Subject data;

  const ListItem({Key key, this.mode, this.bloc, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        data.name,
        // textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        _currentHomeworkStatus(data.status),
        // textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subhead,
      ),
      leading: StatusIcon(
        status: data.status,
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Visibility(
              visible: mode == Mode.student,
              child: MaterialButton(
                onPressed: () {
                  bloc.updateHomeworkStatus(data, context);
                },
                child: Text(
                  _getHomeworkStatus(data.status),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                statusBloc.showStatus(context, data);
              },
              child: Text("Check Status"),
            )
          ],
        )
      ],
    );
  }

  String _currentHomeworkStatus(status) {
    switch (status) {
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

  String _getHomeworkStatus(status) {
    switch (status) {
      case HomeworkStatus.notDone:
        return "Start";
      case HomeworkStatus.onGoing:
        return "Done";
      case HomeworkStatus.completed:
        return "Completed";
      default:
        return "Oops";
    }
  }
}
