import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Project_BoardController {

  /*
  The purpose of this method is to create a Project_Board instance in the
  database based on the attribute values stored in the newBoard which is
  passed in.
   */
  Future<String> createBoard(Project_Board newBoard,int userTypeID, String personNum) async{

    // SERVER API URL
    var url =
          'http://10.100.15.38/createBoard.php';
//        'https://witsinnovativeskyline.000webhostapp.com/createBoard.php';

    String startDate;
    String endDate;
    if(newBoard.Project_StartDate!=null){
      startDate= DateFormat('yyyy-MM-dd').format((newBoard.Project_StartDate));
    }
    if(newBoard.Project_EndDate!=null){
      endDate= DateFormat('yyyy-MM-dd').format((newBoard.Project_EndDate));
    }
    // Store all data with Param Name.
    var data = {
      'Project_Title': newBoard.Project_Title,
      'Project_Description' : newBoard.Project_Description,
      'Project_StartDate' : startDate,
      'Project_EndDate' : endDate,
      'StudentNo' : personNum.toLowerCase(),
      'StaffNo' : personNum.toLowerCase(),
      'userType' : userTypeID.toString()
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    return message;

  }

  /*
  The purpose of this method is to read in all boards associated with the user
  who is currently signed in. The UserTypeID is passed in so that the correct
  SQL statement may be executed (to check the student or supervisor column in
  the Assignment table depending on if the UserTypeID indicates student or
  supervisor). This method should return a list of Project_Board instances
  associated with the specified user.
   */
  // ignore: non_constant_identifier_names
  Future<List<Project_Board>> ReadBoards(int UserTypeID, String personNo) async{
    List<Project_Board> boards=List();


        // SERVER API URL
        var url =
            'http://10.100.15.38/ReadBoards.php';
            //'https://witsinnovativeskyline.000webhostapp.com/ReadBoards.php';

        var data={
          'UserTypeID' : UserTypeID.toString(),
          'StudentNo' : personNo.toLowerCase(),
          'StaffNo' : personNo.toLowerCase()
        };

        // Starting Web API Call.
        var response = await http.post(url, body: data);
        print('User: '+UserTypeID.toString()+", Stud no: "+personNo.toLowerCase()+", StaffNo: "+personNo.toLowerCase()+" Yields: "+response.body);
        // Getting Server response into variable.
        // ignore: non_constant_identifier_names
        var Response = jsonDecode(response.body);
        print(Response);

        String msg='';
        if (Response.length == 0) {

          msg = "No boards created yet. Click the + button to create a board.";

        }
        else {
          user.boards.clear();
          for (int i = 0; i < Response.length; i++) {

            Project_Board boardReceived = new Project_Board();
            boardReceived.ProjectID = int.parse(Response[i]['ProjectID']);
            boardReceived.Project_Title = Response[i]['Project_Title'];
            boardReceived.Project_Description = Response[i]['Project_Description'];
            if(Response[i]['AccessLevelID']!=null){
              boardReceived.AccessLevel=int.parse(Response[i]['AccessLevelID']);
            }

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
    print(msg);
    return boards;
  }

  /*
  The purpose of this method is to update a Project_Board instance in the
  database based on the attribute values stored in the newBoard which is
  passed in.
   */
  Future<String> updateBoard(Project_Board boardToUpdate) async{
    var url =
        'http://10.100.15.38/updateBoard.php';
//        'https://witsinnovativeskyline.000webhostapp.com/updateBoard.php';

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

    return message;
  }

  /*
  The purpose of this method is to delete a Project_Board instance in the
  database based on the ProjectID of the newBoard which is passed in.
   */
  // ignore: non_constant_identifier_names
  Future<String> deleteBoard(int ProjectID) async{

    // SERVER API URL
    var url =
          'http://10.100.15.38/deleteBoard.php';
//        'https://witsinnovativeskyline.000webhostapp.com/deleteBoard.php';

    // Store all data with Param Name.
    var data = {
      'ProjectID': ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    //print(response.body.toString());
    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    return message;
  }




}
