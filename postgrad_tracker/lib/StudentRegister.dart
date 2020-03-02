import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Home.dart';
import 'package:postgrad_tracker/auth.dart';
import 'Login.dart';

class StudentRegisterPage extends StatefulWidget {
//  StudentRegisterPage({Key key, this.title}) : super(key: key);
//  final String title;
  final Function toggleView;
  StudentRegisterPage({ this.toggleView });


  //final Function toggleView;
 // StudentRegisterPage({this.toggleView});
  @override
  _StudentRegisterPageState createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  //text field state
  String email='';
  String password='';
  String ConfirmPass='';
  String firstName='';
  String lastName='';
  String StudentNo='';
  String Degree='';
  String DateReg='';

  @override
  Widget build(BuildContext context) {

    final studentNumberField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a Student Number' : null,
      onChanged: (val){
        setState(() => StudentNo = val);
      },
      style: style,
      decoration: InputDecoration(
          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

          hintText: "Student Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentFirstNameField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a first name' : null,
      onChanged: (val){
        setState(() => firstName = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentLastNameField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a last name' : null,
      onChanged: (val){
        setState(() => lastName = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentEmailField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (val){
        setState(() => email = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentDegreeField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a Degree' : null,
      onChanged: (val){
        setState(() => Degree = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Degree",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentdegreeTypeField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

          hintText: "Degree Type",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final studentDateRegisteredField = TextFormField(
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter Date Registered' : null,
      onChanged: (val){
        setState(() => DateReg = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Date Registered",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      obscureText: true,
      validator: (val) => val.length<6 ? 'Enter a password 6+ chars long' : null,
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
    final confirmPasswordField = TextFormField(
      //validator: (val) => val.toString()==password ? 'Passwords do not match.' : null,
      obscureText: true,
      onChanged: (val){
        setState(() => ConfirmPass = val);

      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if(_formKey.currentState.validate()){
            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
            if(result == null) {
              setState(() {
                error = 'Please supply a valid email';
              });
            }
          }
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

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          widget.toggleView();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child:Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: studentFirstNameField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: studentLastNameField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0, width: 250.0, child: studentEmailField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: studentDegreeField),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: studentDateRegisteredField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: studentNumberField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0, width: 250.0, child: passwordField),
                        SizedBox(
                          height: 15.0,
                          width: 50.0,
                        ),
                        SizedBox(
                            height: 45.0,
                            width: 250.0,
                            child: confirmPasswordField),
                      ]),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 65.0, width: 550.0, child: registerButon),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 65.0, width: 550.0, child: _divider()),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 65.0, width: 550.0, child: loginButon),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          height:15
                      ),
                      Text(error,style: TextStyle(color: Colors.red, fontSize: 14),)
                    ],
                  )
                ],
              ),
            )

          ),
        ),
      ),
    );
  }
}
