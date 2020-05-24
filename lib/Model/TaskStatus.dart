import 'package:flutter/material.dart';

class TaskStatus extends StatefulWidget {
  int TaskStatusID;
  String Status;

   TaskStatus({Key key, this.TaskStatusID, this.Status}) : super(key: key);

  _TaskStatusState createState() => _TaskStatusState();
}

class _TaskStatusState extends State<TaskStatus> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

