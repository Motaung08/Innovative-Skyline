import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/View/Register/StudentSuperVisorRegister.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/User.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {


  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  String msg = '';

  //text field state

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isHidden=true;

  void toggleVisibility(){
    setState(() {
      _isHidden=!_isHidden;
    });
  }
  //

  Future<List> _login() async {


    final response = await http.post(
        "https://witsinnovativeskyline.000webhostapp.com/login.php",
        body: {
          "Email": _emailController.text,
          "Password": _passwordController.text
        });

    var datauser = json.decode(response.body);

    print(datauser);

    if (datauser.length == 0) {
      setState(() {
        msg = "Incorrect email or password!";
        print(msg);
      });
    } else {
      //print('Setting......................');
      setState(() {
       user.email = datauser[0]['Email'];
       user.userTypeID = int.parse(datauser[0]['UserTypeId']);

      });

      if (user.userTypeID==1){

        await studentController.GetStudDetails();

        await project_boardController.ReadBoards();
        setState(() {

        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => homePage),

        );

      }
      else{
        await supervisorController.GetSupDetails();

        await project_boardController.ReadBoards();

        setState(() {

        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => homePage),

        );

      }
      //Navigator.popAndPushNamed(context, '/Home');
    }

    return datauser;
  }


  @override
  Widget build(BuildContext context) {


    final emailField = new TextFormField(
      controller: _emailController,
      obscureText: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter an email address.';
        }
        return null;
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      controller: _passwordController,

      obscureText: _isHidden,
      validator: (val) =>
          val.isEmpty ? 'Password cannot be empty.' : null,
      style: style,
      decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",

          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),) ,
      suffixIcon: IconButton(icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility) , onPressed: toggleVisibility, focusColor: Color(0xff009999),)
      ),

    );


    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _formKey.currentState.validate();
          await _login();
          setState(() {

          });
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (BuildContext context) => homePage),
//
//          );

        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }



    final RegisterButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentSupChoicePage()),
          );
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Widget _divider() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            Text('or'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  emailField,
                  SizedBox(
                    height: 15.0,
                  ),
                  passwordField,
                  SizedBox(
                    height: 15.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                  _divider(),
                  SizedBox(
                    height: 15.0,
                  ),
                  RegisterButon,
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.red, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
