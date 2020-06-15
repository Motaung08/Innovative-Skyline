import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/View/Home.dart';
import 'package:postgrad_tracker/View/register/StudentSuperVisorRegister.dart';
import 'package:postgrad_tracker/View/resetpassword.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

http.Client LoginClient=new http.Client();

class LoginPage extends StatefulWidget {
  bool isHidden = true;
  bool visible = false;
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


  void toggleVisibility() {
    setState(() {
      widget.isHidden = !widget.isHidden;
    });
  }





  @override
  Widget build(BuildContext context) {



    final forgotPassButton =kIsWeb==true? Row(
      children: [
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
        Expanded(
          //flex:1,
          child:   new Container(
            alignment: Alignment.bottomLeft,

            child: FlatButton(
              key: Key("ForgotPasswordInput"),
              onPressed: () {
//                Navigator.pushNamed(context, '/ResetPassword');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => ResetPasswordView()),
                );
              },
              textColor: Color(0xff009999),
              child: Text('Forgot Password?'),
            ),
          ),
        ),
        //emailField,
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
      ],
    )
    :
    new Container(
      alignment: Alignment.bottomLeft,

      child: FlatButton(
        key: Key("ForgotPasswordInput"),
        onPressed: () {
          Navigator.pushNamed(context, '/ResetPassword');
        },
        textColor: Color(0xff009999),
        child: Text('Forgot Password?'),
      ),
    );




    final emailField = kIsWeb==true? Row(
      children: [
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
        Expanded(
          //flex:1,
          child:  new TextFormField(
            key: Key('emailField'),
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
          ),
        ),
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
      ],
    )
    :
    TextFormField(
      controller: _emailController,
      obscureText: false,
      key: Key('emailField'),
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

    final passwordField = kIsWeb==true? Row(
      children: [
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
        Expanded(
          //flex:1,
          child:  new TextFormField(
            key: Key('passwordField'),
            controller: _passwordController,
            obscureText: widget.isHidden,
            validator: (val) => val.isEmpty ? 'Password cannot be empty.' : null,
            style: style,
            decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                suffixIcon: IconButton(
                  key: Key('toggle'),
                  icon:
                  widget.isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  onPressed: toggleVisibility,
                  focusColor: Color(0xff009999),
                )),
          ),
        ),
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
      ],
    )
    :
    new TextFormField(
      key: Key('passwordField'),
      controller: _passwordController,
      obscureText: widget.isHidden,
      validator: (val) => val.isEmpty ? 'Password cannot be empty.' : null,
      style: style,
      decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          suffixIcon: IconButton(
            key: Key('toggle'),
            icon:
            widget.isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: toggleVisibility,
            focusColor: Color(0xff009999),
          )),
    );




    final loginButon = kIsWeb==true? Row(
      children: [
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
        Expanded(
          //flex:1,
          child:   Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff009999),
            child: MaterialButton(
              key: Key('loginButton'),
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                setState(() {
                  widget.visible = true;
                });
                bool proceed = false;
                if (_formKey.currentState.validate()) {
                  user.boards.clear();
                  http.Client client=new http.Client();
                  proceed = await userController.login(
                      _emailController.text, _passwordController.text,client);
//                  print("PROCEED: "+proceed.toString());
                  if (proceed == true) {
                    setState(() {
                      widget.visible = false;
                    });
                    homePage = new HomePage();
                    http.Client client=new http.Client();
                    await homePage.initializeDisplay(client);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => homePage),
                    );
                  } else {
                    setState(() {
                      widget.visible=false;
                      msg="Username or password incorrect";

                    });
                  }

                  setState(() {});
                }
              },
              child: Text("Login",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        //emailField,
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
      ],
    )
    :
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        key: Key('loginButton'),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          bool proceed = false;
          if (_formKey.currentState.validate()) {
            setState(() {
              widget.visible = true;
            });
            user.boards.clear();
//
            proceed = await userController.login(
                _emailController.text, _passwordController.text,LoginClient);

            if (proceed == true) {
              setState(() {
                widget.visible = false;
              });
              homePage = new HomePage();
//              http.Client client=new http.Client();
              await homePage.initializeDisplay(LoginClient);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => homePage),
              );
            } else {
              setState(() {
                widget.visible = false;
                msg="Username or password incorrect";
              });
            }
          }

        },

        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );




    // ignore: non_constant_identifier_names
    final RegisterButon = kIsWeb==true?  Row(
      children: [
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
        Expanded(
          //flex:1,
          child:  Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff009999),
            child: MaterialButton(
              key: Key('registerButton'),
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
          ),
        ),
        Expanded(
          //flex:2,
          child: SizedBox(
            height: 15,
          ),
        ),
      ],
    )
    :
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        key: Key('registerButton'),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentSupChoicePage()),
          );
        },
//        key: Key('RegisterBttnInput'),
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    Widget _divider() {
      return kIsWeb==true? Row(
        children: [
          Expanded(
            //flex:2,
            child: SizedBox(
              height: 15,
            ),
          ),
          Expanded(
            //flex:1,
            child:  Container(
              key: Key('divider'),
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
            ),
          ),
          Expanded(
            //flex:2,
            child: SizedBox(
              height: 15,
            ),
          ),
        ],
      ):
      Container(
        key: Key('divider'),
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
      key: Key('Scaffold'),
      body: Center(
          child: Container(
            alignment: Alignment.center,
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


                      //emailField,
                      SizedBox(
                        height: 15.0,
                      ),
                      passwordField,
                      forgotPassButton,
//                  SizedBox(
//                    height: 15.0,
//                  ),
                      Visibility(
                          visible: widget.visible,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 30, top: 30),
                              child: CircularProgressIndicator())),
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
          ),
        ),
    );
  }
}
