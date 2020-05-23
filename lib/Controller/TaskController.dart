import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/Task.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class TaskController extends StatefulWidget {

  // ignore: non_constant_identifier_names
  Future<List> ReadTasks(int ListID) async{
    List<Task> tasks=new List();
      bool created = false;
      String msg = '';

        // SERVER API URL
        var url =
            //'http://146.141.21.17/ReadBoards.php';
            'https://witsinnovativeskyline.000webhostapp.com/ReadTasks.php';

        var data={
          'ListID' : ListID.toString(),
        };

        // Starting Web API Call.
        var response = await http.post(url, body: data);

        // Getting Server response into variable.
        // ignore: non_constant_identifier_names
        var Response = jsonDecode(response.body);
        print(Response);


        if (Response.length == 0) {

          msg = "No Tasks created yet.";
          print(msg);
        }
        else {
         // print('mmmmmmmmmmmmmmmmmmmmmm lists!');
          tasks=[];

          //Come back and add other task details

          for (int i = 0; i < Response.length; i++) {
            Task taskReceived = new Task();
            taskReceived.TaskID = int.parse(Response[i]['TaskID']);
            taskReceived.Task_Title = Response[i]['Task_Title'];

            taskReceived.Task_StatusID = int.parse(Response[i]['Task_StatusID']);
            if(Response[i]['Task_Date_Due']!=null){
              taskReceived.Task_Due = DateTime.parse(Response[i]['Task_Date_Due']);
            }

            taskReceived.Task_Description = Response[i]['Task_Description'];
            //taskReceived.Task_DateAdded = DateTime.parse(Response[i]['Task_Date_added']);
            taskReceived.Task_AddedBy = Response[i]['Task_AddedBy'];
            taskReceived.ListID = int.parse(Response[i]['ListID']);

            tasks.add(taskReceived);
            print("Added: "+taskReceived.Task_Title);
          }

        }
    return tasks;
  }

  Future createTask(Task aTask) async{
    bool created = false;
      print("CREATING TASK...");

      // SERVER API URL
      var url =
//          'http://146.141.21.17/createBoard.php';
          'https://witsinnovativeskyline.000webhostapp.com/createTask.php';
      //print('================= '+title);
      // Store all data with Param Name.
      var data = {
        //'TaskID': aTask.TaskID.toString(),
        'Task_Title': aTask.Task_Title,
        'ListID':aTask.ListID.toString(),
        'Task_AddedBy':aTask.Task_AddedBy,
        'Task_DateAdded':aTask.Task_DateAdded.toString(),
        'Task_Description':aTask.Task_Description,
        'Task_Due':aTask.Task_Due.toString(),
        'Task_StatusID':aTask.Task_StatusID.toString(),
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      print(response.body);
      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      print(message);




  }

  Future updateTask(Task aTask) async{
    var url =

        'https://witsinnovativeskyline.000webhostapp.com/updateTask.php';

    /*
    $TaskID = $obj['TaskID'];
$ListID = $obj['ListID'];
$Task_Title = $obj['Task_Title'];
$Task_Description = $obj['Task_Description'];
//$AddedBy = $obj['Task_AddedBy'];
$StatusID = $obj['Task_StatusID'];
$DateAdded = $obj['Task_Date_added'];
$DueDate = $obj['Task_Date_Due'];
     */
    String dateAdded;
    String dateDue;
    if(aTask.Task_DateAdded!=null){
      dateAdded=DateFormat("yyyy-MM-dd").format(aTask.Task_DateAdded);
    }
    if(aTask.Task_Due!=null){
      dateDue=DateFormat("yyyy-MM-dd").format(aTask.Task_Due);
    }
    // Store all data with Param Name.
    var data = {
      'TaskID': aTask.TaskID.toString(),
      'Task_Title': aTask.Task_Title,
      'ListID':aTask.ListID.toString(),
      'Task_AddedBy':aTask.Task_AddedBy,
      'Task_Date_added':dateAdded,
      'Task_Description':aTask.Task_Description,
      'Task_Date_Due':dateDue,
      'Task_StatusID':aTask.Task_StatusID.toString(),
    };

    print("UPDATE!");

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);
  }

  Future deleteTask(int TaskID) async{

    // SERVER API URL
    var url =
    //'http://146.141.21.17/ReadBoards.php';
        'https://witsinnovativeskyline.000webhostapp.com/deleteTask.php';

    var data={
      'TaskID' : TaskID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url, body: data);

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);
  }


  @override
  _TaskControllerControllerState createState() => _TaskControllerControllerState();

}

// ignore: camel_case_types
class _TaskControllerControllerState extends State<TaskController> {


  @override
  Widget build(BuildContext context) {
//setState(() {
//
//});
    return Container();
  }
}
