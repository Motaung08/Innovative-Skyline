import 'dart:convert';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class ListController extends StatefulWidget {

  // ignore: non_constant_identifier_names
  Future<List> ReadLists(int ProjectID) async{
    List<ListCard> lists=List();
      bool created = false;
      String msg = '';

        // SERVER API URL
        var url =
            //'http://146.141.21.17/ReadBoards.php';
            'https://witsinnovativeskyline.000webhostapp.com/ReadLists.php';

        var data={
          'ProjectID' : ProjectID.toString(),
        };

        // Starting Web API Call.
        var response = await http.post(url, body: data);

        // Getting Server response into variable.
        // ignore: non_constant_identifier_names
        var Response = jsonDecode(response.body);
        print(Response);


        if (Response.length == 0) {

          msg = "No Lists created yet.";
          print(msg);
        }
        else {
          print('mmmmmmmmmmmmmmmmmmmmmm lists!');
          lists=[];
          for (int i = 0; i < Response.length; i++) {
            ListCard listReceived = new ListCard();
            listReceived.ListID = int.parse(Response[i]['ListID']);
            listReceived.List_Title = Response[i]['List_Title'];
            listReceived.ProjectID= int.parse(Response[i]['ProjectID']);
            listReceived.listTasks=await taskController.ReadTasks(listReceived.ListID);

            lists.add(listReceived);
            //user.boards[listReceived.ProjectID].boardLists[listReceived.ListID].listTasks=await taskController.ReadTasks(listReceived.ListID);
            //print("Added: "+listReceived.List_Title);
          }


          /*At this point all the previously created lists have been read in from
          the model and so the UI should then be populated.
          */
          return lists;
          //boardPage.populateListDisplay();
        }

  }

  Future createList(ListCard newList) async{
    bool created = false;


      // SERVER API URL
      var url =
//          'http://146.141.21.17/createBoard.php';
          'https://witsinnovativeskyline.000webhostapp.com/createList.php';
      //print('================= '+title);
      // Store all data with Param Name.
      var data = {
        'ProjectID': newList.ProjectID.toString(),
        'List_Title': newList.List_Title,
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      print(message);



  }

  Future updateList(ListCard aList) async{
    var url =

        'https://witsinnovativeskyline.000webhostapp.com/updateList.php';


    // Store all data with Param Name.
    var data = {
      'ListID': aList.ListID.toString(),
      'Title' : aList.List_Title,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);
  }

  Future deleteList(int ListID) async{
    //print('We want to delete list '+ListID.toString());
    // SERVER API URL
    var url =
    //'http://146.141.21.17/ReadBoards.php';
        'https://witsinnovativeskyline.000webhostapp.com/deleteList.php';

    var data={
      'ListID' : ListID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url, body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

  }


  @override
  _ListControllerControllerState createState() => _ListControllerControllerState();

}

// ignore: camel_case_types
class _ListControllerControllerState extends State<ListController> {


  @override
  Widget build(BuildContext context) {
//setState(() {
//
//});
    return Container();
  }
}
