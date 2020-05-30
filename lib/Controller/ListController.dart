import 'dart:convert';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class ListController{

  /*
  The purpose of this method is to read in all instances in the List Table in
  the database which as associated with the given ProjectID. Each of these
  lists are then read in as a ListCard object(model) and are then stored in
  a list so that when this method is called, a list containing all the ListCards
  associated with the project is returned. These listCards can then be
  individually accessed and their attributes called upon, such as showing each
  of the list titles of a board when a user navigates to said board page.
   */
  // ignore: non_constant_identifier_names, missing_return
  Future<List<ListCard>> ReadLists(int ProjectID) async{
    List<ListCard> lists=List();

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


        if (Response.length != 0) {

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


        }
    return lists;

  }

  /*
  The following method takes in a listCard - which is populated with values
  from the UI before this method is called - and then uses it's attribute values
  to create a new instance within the List table of the database.
   */
  Future<String> createList(ListCard newList) async{
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

      return message;

  }

  /*
  The following method takes in a listCard - which is populated with values
  previously stored as well as updates from the UI before this method is called
  - and then uses it's attribute values to update the list instance associated
   with the ListID (of the passed in list) in the List table of the database.
   */
  Future<String> updateList(ListCard aList) async{
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

    return message;
  }

  /*
  The following method takes in a listCard - which is populated with values
  previously stored as well as updates from the UI before this method is called
  - and then uses it's attribute values to delete the list instance associated
   with the ListID (of the passed in list) in the List table of the database.
   */
  // ignore: non_constant_identifier_names
  Future<String> deleteList(int ListID) async{
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
    return Response;

  }

}
