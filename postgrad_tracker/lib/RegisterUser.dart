import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Home.dart';

import 'package:postgrad_tracker/main.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;



class Register extends StatefulWidget {
  final Function toggleView;
  final email;
  final password;
  //final confirmPass; // Confirm the password before invoking
  final userType;

  Register({this.toggleView, this.email, this.password, this.userType});
  bool SuccessUser = false;
  bool passwordMatch = false;

  Future userRegistration() async {
    SuccessUser = false;

    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/register_user.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password, 'userType': userType};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      SuccessUser = true;
    }
    //return SuccessUser;


  }


  //final Function toggleView;
  // StudentRegisterPage({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String error = '';

  bool SuccessUser = false;
  bool passwordMatch = false;

  //text field state
  String email = '';
  String password = '';
  String ConfirmPass = '';

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;


  Future userRegistration() async {
    SuccessUser = false;
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    //String name = nameController.text;
    String email = widget.email;
    String password = widget.password;
    String userType = widget.userType;

    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/register_user.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password, 'userType': userType};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
        SuccessUser = true;
      });
    }

//     Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                if (SuccessUser && passwordMatch) {
                  Navigator.pushNamed(context, '/Home');
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }


}
