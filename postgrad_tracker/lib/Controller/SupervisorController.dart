import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/main.dart';

class SupervisorController extends StatefulWidget {

  Future<String> registration(Supervisor supervisorA, User userA) async {
    supervisor.register = false;
    userController.userRegistration(userA);

    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/Register_Supervisor.php';

    // Store all data with Param Name.
    var data = {
      'email': supervisorA.email,
      'StaffNo': supervisorA.staffNo,
      'Sup_FName': supervisorA.fName,
      'Sup_LName': supervisorA.lName,
      'Supervisor_OfficePhone': supervisorA.office,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      supervisor.register = true;
    }
    return message;
  }

  @override
  _SupervisorControllerState createState() => _SupervisorControllerState();
}

class _SupervisorControllerState extends State<SupervisorController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
