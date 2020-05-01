import 'package:flutter/material.dart';

class List extends StatefulWidget {
  final ListID;
  final ProjectID;
  final List_Title;

  const List({Key key, this.ListID, this.ProjectID, this.List_Title}) : super(key: key);


  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

