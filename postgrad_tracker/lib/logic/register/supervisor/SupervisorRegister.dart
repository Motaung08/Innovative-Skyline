import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/ui/login/Login.dart';
import 'package:postgrad_tracker/logic/register/user/RegisterUser.dart';


class SupervisorRegisterPage extends StatefulWidget {
  SupervisorRegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SupervisorRegisterPageState createState() => _SupervisorRegisterPageState();
}

class _SupervisorRegisterPageState extends State<SupervisorRegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  bool SuccessUser = false;
  // ignore: non_constant_identifier_names
  bool SuccessSup = false;
  bool passwordMatch = false;

  //text field state
  String email = '';
  String password = '';
  // ignore: non_constant_identifier_names
  String Confirmpassword = '';
  String firstName = '';
  String lastName = '';
  // ignore: non_constant_identifier_names
  String StaffNo = '';
  // ignore: non_constant_identifier_names
  String Degree = '';
  // ignore: non_constant_identifier_names
  String DateReg = '';
  String error='';


  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

// Getting value from TextField widget.
  final userTypeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  // ignore: non_constant_identifier_names
  final StaffNoController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Sup_FNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Sup_LNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final OfficeController = TextEditingController();

  Future supervisorRegistration() async {
    SuccessSup = false;

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String Sup_FName = Sup_FNameController.text;
    String Sup_LName = Sup_LNameController.text;
    String email = emailController.text;
    String Office = OfficeController.text;
    String StaffNo = StaffNoController.text;
    String password = passwordController.text;
//    String confirmpass = confirmPassController.text;
    String userType=3.toString();


    Register reg = new Register(email: email, password: password,userType: userType);
    reg.userRegistration();
    if (reg.SuccessUser==false){
      print("NBNBNBNBN!!!!!!!!!!!!!!!!! SUCCESS?: "+reg.SuccessUser.toString());
    }


    // SERVER API URL
    var url =
        'https://witsinnovativeskyline.000webhostapp.com/Register_Supervisor.php';

    // Store all data with Param Name.
    var data = {
      'email': email,
      'StaffNo': StaffNo,
      'Sup_FName': Sup_FName,
      'Sup_LName': Sup_LName,
      'Supervisor_OfficePhone': Office,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
        SuccessSup = true;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                //Navigator.of(context).pop();
                //print("SUCCESS USER!?: "+reg.SuccessUser.toString());
                print("SUCCESS SUP?!? "+SuccessSup.toString());

                if (SuccessSup && reg.SuccessUser && passwordMatch) {
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


  checkPasswordMatch() {
    if (passwordController.text == confirmPassController.text) {
      passwordMatch = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffNumberField = TextFormField(
      controller: StaffNoController,
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a Staff Number' : null,
      onChanged: (val) {
        setState(() => StaffNo = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Staff Number",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffFirstNameField = TextFormField(
      obscureText: false,
      controller: Sup_FNameController,
      validator: (val) => val.isEmpty ? 'Enter a First Name' : null,
      onChanged: (val) {
        setState(() => firstName = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffLastNameField = TextFormField(
      controller: Sup_LNameController,
      obscureText: false,
      style: style,
      validator: (val) => val.isEmpty ? 'Enter a Last Name' : null,
      onChanged: (val) {
        setState(() => lastName = val);
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffEmailField = TextFormField(
      controller: emailController,
      obscureText: false,
      style: style,
      validator: (val) => val.isEmpty ? 'Enter n email address.' : null,
      onChanged: (val) {
        setState(() => email = val);
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffOfficeField = TextFormField(
      controller: OfficeController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Office",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      validator: (val) =>
      val.length < 6 ? 'Enter a Password with 6+ chars.' : null,
      onChanged: (val) {
        setState(() => password = val);
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmPasswordField = TextFormField(
      controller: confirmPassController,
      obscureText: true,
      style: style,
      validator: (val) {

        if (val.isEmpty) {
          return 'Confirm password.';
        }
        if (val !=confirmPassController.text){
          return 'Passwords must match';
        }
        return null;
      },
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
          _formKey.currentState.validate();
          checkPasswordMatch();
          supervisorRegistration();
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //widget.toggleView();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("Login",
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
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(children: <Widget>[
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width: 150.0, child: staffFirstNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(width: 150.0, child: staffLastNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(width: 150.0, child: staffEmailField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(width: 150.0, child: staffOfficeField),
                            ]),
                            Column(children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                            ]),
                            Column(children: <Widget>[
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(width: 150.0, child: staffNumberField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(width: 150.0, child: passwordField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width: 150.0, child: confirmPasswordField),
                            ]),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        registerButon,
                        SizedBox(
                          height: 15.0,
                        ),
                        Visibility(
                            visible: visible,
                            child: Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: CircularProgressIndicator())),
                        _divider(),
                        SizedBox(
                          height: 15.0,
                        ),
                        loginButon,
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}