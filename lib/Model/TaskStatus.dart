import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskStatus extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int TaskStatusID;
  // ignore: non_constant_identifier_names
  String Status;

   // ignore: non_constant_identifier_names
   TaskStatus({Key key, this.TaskStatusID, this.Status}) : super(key: key);

  _TaskStatusState createState() => _TaskStatusState();
}

class _TaskStatusState extends State<TaskStatus> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

