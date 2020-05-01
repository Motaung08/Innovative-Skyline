import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/main.dart';

class UserController extends StatefulWidget {

  Future userRegistration(User userA) async {
    user.register = false;

    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/register_user.php';

    // Store all data with Param Name.
    var data = {'email': userA.email, 'password': userA.password, 'userType': userA.userTypeID};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      user.register=true;
    }
    //return SuccessUser;
  }



  @override
  _UserControllerState createState() => _UserControllerState();
}

class _UserControllerState extends State<UserController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
