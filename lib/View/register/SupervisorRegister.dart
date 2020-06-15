
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/main.dart';


class SupervisorRegisterPage extends StatefulWidget {
  bool isHidden=true;
  bool isHiddenConf=true;
  @override
  _SupervisorRegisterPageState createState() => _SupervisorRegisterPageState();
}



class _SupervisorRegisterPageState extends State<SupervisorRegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  String error='';

  Supervisor supervisorA=new Supervisor();
  User userA=new User();
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

// Getting value from TextField widget.
  final userTypeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  final staffNoController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Sup_FNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Sup_LNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final OfficeController = TextEditingController();

  Future supervisorRegistration() async {
    supervisor.register=false;

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });


    // Getting value from Controller
    supervisorA.fName = Sup_FNameController.text;
    supervisorA.lName = Sup_LNameController.text;
    supervisorA.email = emailController.text;
    userA.email=supervisorA.email;
    supervisorA.office = OfficeController.text;
    supervisorA.staffNo= staffNoController.text;
    userA.password = passwordController.text;
    userA.userTypeID=2;

    var registered = await supervisorController.registration(supervisorA, userA);
//    print("IN SUP REG : "+registered);



    if (supervisor.register==true){
      setState(() {
        visible=false;
        supervisor.email=supervisorA.email;
        supervisor.fName=supervisorA.fName;
        supervisor.lName=supervisorA.lName;
        supervisor.staffNo=supervisorA.staffNo;
        supervisor.office=supervisorA.office;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(registered),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              key: Key("FlatButton"),
              onPressed: () {
                //Navigator.of(context).pop();

                if (supervisor.register && user.register) {
                  Navigator.pushNamed(context, '/Login');
                } else {
                  setState(() {
                    visible=false;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }



  void toggleVisibility(){
    setState(() {
      widget.isHidden=!widget.isHidden;
    });
  }



  void toggleVisibilityConf(){
    setState(() {
      widget.isHiddenConf=!widget.isHiddenConf;
    });
  }


  @override
  Widget build(BuildContext context) {
    final staffNumberField = TextFormField(
      key: Key('staffNumber'),
      controller: staffNoController,
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a Staff Number' : null,
      onChanged: (val) {
        setState(() => supervisorA.staffNo = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Staff Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffFirstNameField = TextFormField(
      key: Key('firstName'),
      obscureText: false,
      controller: Sup_FNameController,
      validator: (val) => val.isEmpty ? 'Enter a First Name' : null,
      onChanged: (val) {
        setState(() => supervisorA.fName = val);
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffLastNameField = TextFormField(
      key: Key('lastName'),
      controller: Sup_LNameController,
      obscureText: false,
      style: style,
      validator: (val) => val.isEmpty ? 'Enter a Last Name' : null,
      onChanged: (val) {
        setState(() => supervisorA.lName = val);
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffEmailField = TextFormField(
      key: Key('email'),
      controller: emailController,
      obscureText: false,
      style: style,
      validator: (val){
        if (val.isEmpty) {
          return 'Please enter an email address!.';
        }
        if (val.contains("@wits.ac.za")==false){
          return 'Invalid staff email address';
        }
        return null;
      },
      onChanged: (val) {
        setState(() => supervisorA.email = val);
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final staffOfficeField = TextFormField(
      key: Key('office'),
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
      key: Key('password'),
      controller: passwordController,
      validator: (val) =>
          val.length < 6 ? 'Enter a Password with 6+ chars.' : null,
      onChanged: (val) {
        setState(() => userA.password = val);
      },
      obscureText: widget.isHidden,
      style: style,
      decoration: InputDecoration(
          suffixIcon: IconButton(icon: widget.isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility), onPressed: toggleVisibility),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmPasswordField = TextFormField(
      key: Key('confPass'),
      controller: confirmPassController,
      obscureText: widget.isHiddenConf,
      style: style,
      validator: (val) {

        if (val.isEmpty) {
          return 'Confirm password.';
        }
        if (val !=passwordController.text){
          return 'Passwords must match';
        }
        return null;
      },

      decoration: InputDecoration(
          suffixIcon: IconButton(icon: widget.isHiddenConf ? Icon(Icons.visibility_off) : Icon(Icons.visibility), onPressed: toggleVisibilityConf),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButon = kIsWeb? Row(
      children: [
        Expanded(
          child: Text("")
        ),
        Expanded(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff009999),
            child: MaterialButton(
              key: Key('RegisterButton'),
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  supervisorRegistration();
                }

              },
              child: Text("Register",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Expanded(
          child:Text("")
        )
      ],
    ):
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        key: Key('RegisterButton'),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if(_formKey.currentState.validate()){
            supervisorRegistration();
          }

        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButon = kIsWeb? Row(
      children: [
        Expanded(
          child:Text("")
        ),
        Expanded(
          child:  Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff009999),
            child: MaterialButton(
              key: Key('LoginButton'),
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
          ),
        ),
        Expanded(
          child: Text(""),
        )
      ],
    ):
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        key: Key('LoginButton'),
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
        key: Key('Divider'),
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
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Padding(
              padding: kIsWeb? EdgeInsets.all(5) : const EdgeInsets.all(36.0),
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
                        kIsWeb?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child:Text("")
                            ),
                            Expanded(
                              //flex:3,
                              child: Column(children: <Widget>[
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                   // width: 150.0,
                                    child: staffFirstNameField),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: staffLastNameField),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: staffEmailField),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: staffOfficeField),
                              ]),
                            ),
                            Column(children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                            ]),
                            Expanded(
                              child: Column(children: <Widget>[
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: staffNumberField),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: passwordField),
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                    //width: 150.0,
                                    child: confirmPasswordField),
                              ]),
                            ),
                            Expanded(
                                child:Text("")
                            ),
                          ],
                        )
                        :
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Column(children: <Widget>[
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                 width: 150.0,
                                  child: staffFirstNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 150.0,
                                  child: staffLastNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 150.0,
                                  child: staffEmailField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 150.0,
                                  child: staffOfficeField),
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
                              SizedBox(
                                width: 150.0,
                                  child: staffNumberField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 150.0,
                                  child: passwordField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 150.0,
                                  child: confirmPasswordField),
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
