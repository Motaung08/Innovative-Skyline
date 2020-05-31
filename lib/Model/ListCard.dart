import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/Task.dart';

// ignore: must_be_immutable
class ListCard extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int ListID;
  // ignore: non_constant_identifier_names
  int ProjectID;
  // ignore: non_constant_identifier_names
  String List_Title;



  List<Task> listTasks=new List<Task>();
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

