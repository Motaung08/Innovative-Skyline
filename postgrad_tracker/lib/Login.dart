import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Home.dart';
import 'package:postgrad_tracker/StudentSuperVisorRegister.dart';
import 'package:postgrad_tracker/auth.dart';
import 'StudentSuperVisorRegister.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

//  final Function toggleView;
//  LoginPage({ this.toggleView });
  final AuthService _auth = AuthService();
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  Future<String> getData() async{
    http.Response response = await http.get(
        Uri.encodeFull("https://innovativeskyline.000webhostapp.com/get.php"),
      headers: {
          //May be required depending on API
//          "key" : ""
        "Accept" : "application/json"
      }

    );
    print(response.body);
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  //text field state
  String email='';
  String password='';
  final _emailController =  TextEditingController();
  final _passwordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    getData();






    final emailField = new TextFormField(
      controller: _emailController,
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Username cannot be blank.' : null,
      onChanged: (val){
        setState(() => email = val);
      },
      style: style,
//      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//      onSaved: (value) => _email = value.trim(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final passwordField = TextFormField(
      controller: _passwordController,
      obscureText: true,
      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
      onChanged: (val){
        setState(() => password = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );



    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _performLogin();
          ///////////////////////////////////////////
          //Bypass the login - go straight to home page.

           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );

          ///////////////////////////////////////////

          //-------------------------------
          //Showcase login functionalitym
//          if (_formKey.currentState.validate()) {
//            dynamic result = await _auth.signInWithEmailAndPassword(
//                email, password);
//
//            if (result == null) {
//              setState(() {
//                error = 'Could not sign in with those credentials';
//
//              });//setState
//            }//if
//            else{
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => HomePage()),
//              );
//            }
//          }

          //-------------------------------------

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

         // widget.toggleView();
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
                      SizedBox (
                        height: 15.0,
                      ),
                      RegisterButon,

//                      Text(
//                        error,
//                        style: TextStyle(color: Colors.red, fontSize: 14.0),
//                      ),

                    ],
                  ),
              ),
            ),
          ),
          )

      ),
    );
  }
  void _performLogin() {
    String username = _emailController.text;
    String password = _passwordController.text;

    print('login attempt: $username with $password');
  }
}

