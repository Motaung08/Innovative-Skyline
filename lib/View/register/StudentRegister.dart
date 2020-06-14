import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Model/DegreeType.dart';

import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/StudentType.dart';

import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Login.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;


import '../../main.dart';
http.Client studRegClient=new http.Client();
class StudentRegisterPage extends StatefulWidget {
  bool isHidden = true;
  Future initialize(http.Client client) async {
    await studentTypeController.getTypes(client);
    await degreeController.getDegrees(client);
    print('Student type ' + studentTypes.length.toString());
  }

  @override
  _StudentRegisterPageState createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  bool test=false;
  Future initializeRegister(http.Client client) async {
    await widget.initialize(client);

    //widget.initialize();
    _dropdownMenuItems = buildDropdownMenuItems(degrees);
    _selectedDegree = degrees[0];
    //print('Degrees size: '+degrees.length.toString());

    _dropdownStudTypeMenuItems =
        buildDropdownStudentTypeMenuItems(_studenttype);
    _selectedStudType = _dropdownStudTypeMenuItems[0].value;
    setState(() {});
  }

  DateTime _date;
  final format = DateFormat("yyyy-MM-dd");
  String dateinput = "Select date ...";
  TextStyle datestyle = TextStyle(
      color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2030));

    if (picked != null) {
      print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
    datestyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');
    dateinput = DateFormat('yyyy-MM-dd').format(_date);
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  List<DropdownMenuItem<DegreeType>> _dropdownMenuItems;
  DegreeType _selectedDegree;

  List<StudentType> _studenttype = studentTypes;
  List<DropdownMenuItem<StudentType>> _dropdownStudTypeMenuItems;
  StudentType _selectedStudType;

  @override
  // ignore: must_call_super
  void initState() {
    initializeRegister(studRegClient);
//    super.initState();
  }

  List<DropdownMenuItem<DegreeType>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<DegreeType>> items = List();
    for (DegreeType degree in companies) {
      items.add(
        DropdownMenuItem(
          value: degree,
          child: Text(
            degree.Degree_Type,
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Montserrat', fontSize: 20.0),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(DegreeType selectedDegree) {
    setState(() {
      _selectedDegree = selectedDegree;
    });
  }

  List<DropdownMenuItem<StudentType>> buildDropdownStudentTypeMenuItems(
      List types) {
    List<DropdownMenuItem<StudentType>> items = List();
    for (StudentType type in types) {
      items.add(
        DropdownMenuItem(
          value: type,
          child: Text(
            type.Student_Type,
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Montserrat', fontSize: 20.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return items;
  }

  onChangeStudTypeDropdownItem(StudentType selectedType) {
    setState(() {
      _selectedStudType = selectedType;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String error = '';

  // ignore: non_constant_identifier_names
  bool SuccessUser = false;
  // ignore: non_constant_identifier_names
  bool SuccessStudent = false;
  bool passwordMatch = false;

  TextEditingController confirmPassCont = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController StudentTypeCont = new TextEditingController();

  //text field state
  String email = '';
  String password = '';
  // ignore: non_constant_identifier_names
  String ConfirmPass = '';
  String firstName = '';
  String lastName = '';
  // ignore: non_constant_identifier_names
  String StudentNo = '';
  // ignore: non_constant_identifier_names
  String Degree = '';
  String studentType = '';
  // ignore: non_constant_identifier_names
  String DateReg = '';

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

// Getting value from TextField widget.
  final studentTypeTextController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  final StudentNoController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Student_FNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final Student_LNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final DegreeTypeController = TextEditingController();
  // ignore: non_constant_identifier_names
  final RegistrationDateController = TextEditingController();

  Future studentRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    User userA = new User();

    Student studentA = new Student();

    // Getting value from Controller

    userA.email = emailController.text;
    studentA.email = userA.email;
    userA.password = passwordController.text;
    userA.userTypeID = 1;
    studentA.studentNo = StudentNoController.text;
    studentA.fName = Student_FNameController.text;
    studentA.lName = Student_LNameController.text;
    //studentA.degreeID = int.parse(DegreeTypeController.text);

    //studentA.degreeID=1;

    studentA.degreeID = _selectedDegree.DegreeID;

    studentA.registrationDate = DateTime.parse(RegistrationDateController.text);
    //studentA.studentTypeID=int.parse(studentTypeController.text);
    userA.userTypeID = 1;

    // studentA.studentTypeID=1;

    studentA.studentTypeID = _selectedStudType.StudentTypeID;


    String registered=await studentController.studentRegistration(studentA, userA);

    print("REGISTER OUTPUT: " + registered);
    String message = "";
    //Empty string indicates no errors -> success
    if (registered == "") {
      message = "Successfuly registered.";
    } else {
      message = registered;
    }
    print('...............Student registration:      ' +
        message +
        '      ...............');

    if (student.register == true) {
      setState(() {
        visible = false;
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
                if (student.register == true) {
                  Navigator.pushNamed(context, '/Login');
                } else {
                  setState(() {
                    visible = false;
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



  void toggleVisibility() {
    setState(() {
      widget.isHidden = !widget.isHidden;
    });
  }

  bool _isHiddenConf = true;

  void toggleVisibilityConf() {
    setState(() {
      _isHiddenConf = !_isHiddenConf;
    });
  }

  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    //widget.initialize();
    //initializeRegister();

    final studentNumberField = TextFormField(
      key: Key('studNo'),
      controller: StudentNoController,
      obscureText: false,
      validator: (val) => val.isEmpty ? 'Enter a Student Number' : null,
      onChanged: (val) {
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
            key: Key('firstName'),
            controller: Student_FNameController,
            obscureText: false,
            validator: (val) => val.isEmpty ? 'Enter a first name' : null,
            onChanged: (val) {
              setState(() => firstName = val);
            },
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "First Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          );

    final studentLastNameField = TextFormField(
            key: Key('lastName'),
            controller: Student_LNameController,
            obscureText: false,
            validator: (val) => val.isEmpty ? 'Enter a last name' : null,
            onChanged: (val) {
              setState(() => lastName = val);
            },
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Last Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          );

    final studentEmailField = TextFormField(
            key: Key('email'),
            controller: emailController,
            obscureText: false,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter an email address!.';
              }
              if (val.contains("@students.wits.ac.za") == false) {
                return 'Invalid student email address';
              }
              return null;
            },
            onChanged: (val) {
              setState(() => email = val);
            },
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          );

    final dropdownDegree = new Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    value: _selectedDegree,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                    isExpanded: true,
                    key: Key('DropDownDegree'),

                    //style: style,

                    //style: style,
                  ),

                  //Text('Selected: ${_selectedDegree.DegreeType}'),
                ],
              ),
            ),
          );

    final dropdownStudType =
         new Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    value: _selectedStudType,
                    items: _dropdownStudTypeMenuItems,
                    onChanged: onChangeStudTypeDropdownItem,
                    isExpanded: true,
                    key: Key('DropDownStudType'),

                    //style: style,

                    //style: style,
                  ),

                  //Text('Selected: ${_selectedDegree.DegreeType}'),
                ],
              ),
            ),
          );

    RegistrationDateController.text = _date.toString();
//    final dateform =  Stack(
//      children: <Widget>[
//        Container(
//          width: double.infinity,
//          height: 60,
//          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//          //padding: EdgeInsets.only(bottom: 10),
//          decoration: BoxDecoration(
//            border: Border.all(
//                color: Colors.grey, width: 1),
//            borderRadius: BorderRadius.circular(32),
//            shape: BoxShape.rectangle,
//          ),
//          child:  Padding(
//            padding: EdgeInsets.only(left: 20, right: 20,),
//            child: DateTimeFormField(
//              initialValue: null,
//              label: "",
//              validator: (DateTime dateTime) {
//                if (dateTime == null) {
//                  return "Date Time Required";
//                }
//                return null;
//              },
//              onSaved: (DateTime dateTime) => _dateTime = dateTime,
//            ),
//          )
//        ),
//        Positioned(
//            left: 10,
//            top: 12,
//            child: Container(
//              padding: EdgeInsets.only(bottom: 10, left: 3, right: 0),
//              margin: EdgeInsets.only(left: 10),
//              color: Colors.white,
//              child: Text(
//                'Date Registered: ',
//                style: TextStyle(color: Colors.black.withOpacity(.65)),
//              ),
//            ))
//      ],
//    );

    // ignore: non_constant_identifier_names
    final DateSelection =
         new Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                //padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(32),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color(0xff009999),
                      ),
                      key: Key('RegDateButton'),
                      onPressed: () {
                        selectDate(context);
                      },
                      tooltip: "Select registration date",
                    ),
                    Text(
                      dateinput,
                      style: datestyle,
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 10,
                  top: 12,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, left: 3, right: 0),
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    child: Text(
                      'Date Registered: ',
                      style: TextStyle(color: Colors.black.withOpacity(.65)),
                    ),
                  )),
            ],
          );

    final passwordField =
         TextFormField(
            controller: passwordController,
            key: Key('password'),
            obscureText: widget.isHidden,
            validator: (val) =>
                val.length < 6 ? 'Enter a password 6+ chars long' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
            style: style,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: widget.isHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: toggleVisibility),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          );

    final confirmPasswordField =
        TextFormField(
            controller: confirmPassCont,
            key: Key('confirmPass'),
            validator: (val) {
              if (val.isEmpty) {
                return 'Confirm password.';
              }
              if (val != passwordController.text) {
                return 'Passwords must match';
              }
              return null;
            },
            obscureText: _isHiddenConf,
            onChanged: (val) {
              setState(() => ConfirmPass = val);
            },
            style: style,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: _isHiddenConf
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: toggleVisibilityConf),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          );

    //final RegisterUser
    final registerButon = kIsWeb? Row(
      children: [
        Expanded(
          child: Text(""),
        ),
        Expanded(
            //flex:3,
            child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xff009999),
          child: MaterialButton(
            key: Key("reg"),
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_date == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("No registration date selected ..."),
                        content: Text(
                            "Enter the registration date of your current postgraduate degree so that deadlines may be calculated."),
                        actions: <Widget>[
                          FlatButton(
                            child: new Text("OK"),
                            onPressed: () {
                              setState(() {
                                visible = false;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  studentRegistration();
                }
              }
            },
            child: Text("Register",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
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
        key: Key('registerButton'),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            if (_date == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("No registration date selected ..."),
                    content: Text(
                        "Enter the registration date of your current postgraduate degree so that deadlines may be calculated."),
                    actions: <Widget>[
                      FlatButton(
                        child: new Text("OK"),
                        onPressed: () {
                          setState(() {
                            visible = false;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              studentRegistration();
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

    final loginButon = kIsWeb? Row(
      children: [
        Expanded(child: Text("")),
        Expanded(
          //flex: 3,
          child: Material(
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
          ),
        ),
        Expanded(child: Text("")),
      ],
    ):
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        key: Key('loginButton'),
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

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
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
                      SizedBox(
                        height: 15.0,
                      ),
                      kIsWeb?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(""),
                          ),
                          Expanded(
                            child: Column(children: <Widget>[
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: studentFirstNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: studentLastNameField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: studentEmailField),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: dropdownDegree),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: dropdownStudType),
                              SizedBox(
                                height: 15.0,
                              ),
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
                                width: MediaQuery.of(context).size.width / 2.8,
                                child:
                                    //dateform
                                    DateSelection),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: studentNumberField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: passwordField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: confirmPasswordField),
                          ])),
                          Expanded(
                            child: Text(""),
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
                                width:
                                MediaQuery.of(context).size.width / 2.8,
                                child: studentFirstNameField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 2.8,
                                child: studentLastNameField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 2.8,
                                child: studentEmailField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 2.8,
                                child: dropdownDegree),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 2.8,
                                child: dropdownStudType),
                            SizedBox(
                              height: 15.0,
                            ),
                          ]),
                          Column(children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                          ]),
                          Column(children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child:
                                //dateform
                                DateSelection),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: studentNumberField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: passwordField),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                child: confirmPasswordField),
                          ]),

                        ],
                      ),
                      registerButon,
                      Visibility(
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 30, top: 30),
                              child: CircularProgressIndicator())),
                      _divider(),
                      loginButon,
                    ],
                  )))),
        ),
      ),
    );
  }
}
