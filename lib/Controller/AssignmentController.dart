import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssignmentController extends StatefulWidget {

  Future createAssignment(int OtherUserType, String OtherPersonNo, int ProjectID, int AccessID) async{
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/createAssignment.php';

    var data={
      'UserTypeID' : OtherUserType.toString(),
      'AssignPerson' : OtherPersonNo,
      'ProjectID' : ProjectID.toString(),
      'AccessLevelID' : AccessID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);



  }

  @override
  _AssignmentControllerState createState() => _AssignmentControllerState();
}

class _AssignmentControllerState extends State<AssignmentController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
