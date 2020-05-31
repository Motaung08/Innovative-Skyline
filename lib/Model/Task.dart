import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Task extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int TaskID;
  // ignore: non_constant_identifier_names
  int ListID;
  // ignore: non_constant_identifier_names
  String Task_Title;
  // ignore: non_constant_identifier_names
  String Task_Description;
  // ignore: non_constant_identifier_names
  String Task_AddedBy;
  // ignore: non_constant_identifier_names
  int Task_StatusID;
  // ignore: non_constant_identifier_names
  DateTime Task_DateAdded;
  // ignore: non_constant_identifier_names
  DateTime Task_Due;


  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

