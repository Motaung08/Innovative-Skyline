import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Project_BoardController extends StatefulWidget {

  /*
  The purpose of this method is to read in all boards associated with the user
  who is currently signed in. The UserTypeID is passed in so that the correct
  SQL statement may be executed (to check the student or supervisor column in
  the Assignment table depending on if the UserTypeID indicates student or
  supervisor). This method should return a list of Project_Board instances
  associated with the specified user.
   */
  // ignore: non_constant_identifier_names
  Future<List> ReadBoards(int UserTypeID, String personNo) async{
    List<Project_Board> boards=List();
      bool created = false;
      String msg = '';

      if (user.userTypeID==1){
        supervisor.staffNo="";
      }else{
        student.studentNo="";
      }



        // SERVER API URL
        var url =
            //'http://146.141.21.17/ReadBoards.php';
            'https://witsinnovativeskyline.000webhostapp.com/ReadBoards.php';

        var data={
          'UserTypeID' : user.userTypeID.toString(),
          'StudentNo' : student.studentNo,
          'StaffNo' : supervisor.staffNo
        };

        // Starting Web API Call.
        var response = await http.post(url, body: data);

        // Getting Server response into variable.
        // ignore: non_constant_identifier_names
        var Response = jsonDecode(response.body);
        print(Response);


        if (Response.length == 0) {

          msg = "No boards created yet. Click the + button to create a board.";
          print(msg);
        }
        else {
          user.boards.clear();
          for (int i = 0; i < Response.length; i++) {

            Project_Board boardReceived = new Project_Board();
            boardReceived.ProjectID = int.parse(Response[i]['ProjectID']);
            boardReceived.Project_Title = Response[i]['Project_Title'];
            boardReceived.Project_Description = Response[i]['Project_Description'];
            //print("START DATE: "+Response[i]['Project_StartDate'].toString());
            if(Response[i]['Project_StartDate']!=null){
              boardReceived.Project_StartDate=DateTime.parse(Response[i]['Project_StartDate']);
            }
            if(Response[i]['Project_EndDate']!=null){
              boardReceived.Project_EndDate=DateTime.parse(Response[i]['Project_EndDate']);
            }

            //boardReceived.boardLists=await listController.ReadLists(boardReceived.ProjectID);

            boards.add(boardReceived);
            //user.boards.add(boardReceived);
            //user.boards[i].boardLists=await listController.ReadLists(boardReceived.ProjectID);
          }



        }
    return boards;
  }

  /*
  The purpose of this method is to create a Project_Board instance in the
  database based on the attribute values stored in the newBoard which is
  passed in.
   */
  Future createBoard(Project_Board newBoard) async{
    bool created = false;

    if(user.userTypeID==1){
      supervisor.staffNo="";
    }
    else{
      student.studentNo="";
    }

      // SERVER API URL
      var url =
//          'http://146.141.21.17/createBoard.php';
          'https://witsinnovativeskyline.000webhostapp.com/createBoard.php';

      // Store all data with Param Name.
      var data = {
        'Project_Title': newBoard.Project_Title,
        'Project_Description' : newBoard.Project_Description,
        'Project_StartDate' : DateFormat('yyyy-MM-dd').format((newBoard.Project_StartDate)),
        'Project_EndDate' : DateFormat('yyyy-MM-dd').format((newBoard.Project_EndDate)),
        'StudentNo' : student.studentNo,
        'StaffNo' : supervisor.staffNo,
        'userType' : user.userTypeID.toString()
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      var message = jsonDecode(response.body);

      print(message);



  }

  /*
  The purpose of this method is to delete a Project_Board instance in the
  database based on the ProjectID of the newBoard which is passed in.
   */
  Future deleteBoard(int ProjectID) async{

    // SERVER API URL
    var url =
//          'http://146.141.21.17/createBoard.php';
        'https://witsinnovativeskyline.000webhostapp.com/deleteBoard.php';

    // Store all data with Param Name.
    var data = {
      'ProjectID': ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    //print(response.body.toString());
    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);



  }

  /*
  The purpose of this method is to update a Project_Board instance in the
  database based on the attribute values stored in the newBoard which is
  passed in.
   */
  Future updateBoard(Project_Board boardToUpdate) async{
    var url =

        'https://witsinnovativeskyline.000webhostapp.com/updateBoard.php';

    String startDate;
    if(boardToUpdate.Project_StartDate!=null){
      startDate=DateFormat('yyyy-MM-dd').format(boardToUpdate.Project_StartDate);
    }
    else{
     startDate=null;
    }

    String endDate;
    if(boardToUpdate.Project_EndDate!=null){
      endDate=DateFormat('yyyy-MM-dd').format(boardToUpdate.Project_EndDate);
    }
    else{
      endDate=null;
    }



    // Store all data with Param Name.
    var data = {
      'BoardID': boardToUpdate.ProjectID,
      'Title' : boardToUpdate.Project_Title,
      'Description' : boardToUpdate.Project_Description,
      'Start' : startDate,
      'End' : endDate,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);
  }


  @override
  _Project_BoardControllerState createState() => _Project_BoardControllerState();

}

// ignore: camel_case_types
class _Project_BoardControllerState extends State<Project_BoardController> {


  @override
  Widget build(BuildContext context) {
//setState(() {
//
//});
    return Container();
  }
}
