import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/TaskStatus.dart';
import 'package:postgrad_tracker/main.dart';

class TaskStatusController{
  /*
  The purpose of this method is to read in all instances in the TaskStatus table
  in the database so that when creating or updating a task, a pre-populated list
  of task statuses may be shown to be chosen from.
   */
  Future<void> getStatuses({url="http://10.100.15.38/getTaskStatuses.php"}) async{
    //print('I am called');

    final response = await http.post(url);
    print("RESPONSE: ");
    print(response.body);
//    final response = await http.post("https://witsinnovativeskyline.000webhostapp.com/getTaskStatuses.php");

    //print('Assigning title for '+student.studentTypeID.toString());
    var result = json.decode(response.body);

    taskStatuses.clear();
    for (int i=0; i<result.length;i++){
      TaskStatus taskStatus = new TaskStatus();
      taskStatus.TaskStatusID =int.parse(result[i]['Task_StatusID']);
      taskStatus.Status=result[i]['Status'];
      taskStatuses.add(taskStatus);
//      print("TASK yoodle: "+taskStatus.Status);
    }
    //print("THIS TASK STATUS LENGTH: "+taskStatuses.length.toString());

  }

}
