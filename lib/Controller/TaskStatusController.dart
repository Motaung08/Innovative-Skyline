import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/TaskStatus.dart';
import 'package:postgrad_tracker/main.dart';

class TaskStatusController extends StatefulWidget {
  Future getStatuses() async{
    //print('I am called');
//    final response = await http.post("http://146.141.21.17/getStudentTypes.php");
    final response = await http.post("https://witsinnovativeskyline.000webhostapp.com/getTaskStatuses.php");

    //print('Assigning title for '+student.studentTypeID.toString());

    var result = json.decode(response.body);
    print(result);
    taskStatuses.clear();
    for (int i=0; i<result.length;i++){
      TaskStatus taskStatus = new TaskStatus();
      taskStatus.TaskStatusID =int.parse(result[i]['Task_StatusID']);
      taskStatus.Status=result[i]['Status'];
      taskStatuses.add(taskStatus);
    }


  }

  @override
  _TaskStatusControllerState createState() => _TaskStatusControllerState();
}

class _TaskStatusControllerState extends State<TaskStatusController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
