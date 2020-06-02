import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/UserController.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/Board.dart';
import 'package:postgrad_tracker/main.dart';

final List<DynamicWidget> listDynamic = [];

class HomePage extends StatefulWidget {
  initializeDisplay() async {
    Project_BoardController projectBoardController=new Project_BoardController();
    user.boards= await projectBoardController.ReadBoards(user.userTypeID,personNo);
    listDynamic.clear();
    print('Initializing board display! ##################');
    for (int i = 0; i < user.boards.length; i++) {
      print("Board ID: "+user.boards[i].ProjectID.toString()+", Title: "+user.boards[i].Project_Title);
      listDynamic.add(new DynamicWidget(aboard: user.boards[i]));
    }
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  String boardTitle = "";
  final _formKey = GlobalKey<FormState>();
  //int userType=user.userTypeID;

  DateTime _startDate;
  DateTime _endDate;
  final format = DateFormat("yyyy-MM-dd");
  String startDateInput = "Select date ...";
  String endDateInput = "Select date ...";
  TextStyle dateStyle = TextStyle(
      color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');

  Future<Null> selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2030));

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
    dateStyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');
    startDateInput = DateFormat('yyyy-MM-dd').format(_startDate);
  }

  Future<Null> selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2030));

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
    dateStyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');
    endDateInput = DateFormat('yyyy-MM-dd').format(_endDate);
  }

  Future<String> createAlertDialog(BuildContext context) {
    titleController.text = "";
    descriptionController.text = "";
    startDateInput = "Select date ...";
    endDateInput = "Select date ...";
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Create Board: "),
              content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: titleController,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Board Title' : null,
                            decoration: InputDecoration(
                                //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "* Board Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                                //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 60,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              //padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.rectangle,
                              ),
                              child: MaterialButton(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Color(0xff009999),
                                      ),
                                      onPressed: () {},
                                      tooltip: "Select start date",
                                    ),
                                    Text(
                                      startDateInput,
                                      style: dateStyle,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await selectStartDate(context);


                                  setState(() {
                                    startDateInput = DateFormat('yyyy-MM-dd')
                                        .format(_startDate);
                                  });
                                },
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: 12,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 3, right: 0),
                                  margin: EdgeInsets.only(left: 10),
                                  color: Colors.white,
                                  child: Text(
                                    'Start Date:',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.65)),
                                  ),
                                )),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 60,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              //padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.rectangle,
                              ),
                              child: MaterialButton(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Color(0xff009999),
                                      ),
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      tooltip: "Select end date",
                                    ),
                                    Text(
                                      endDateInput,
                                      style: dateStyle,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await selectEndDate(context);

                                  setState(() {
                                    endDateInput =
                                        DateFormat('yyyy-MM-dd').format(_endDate);
                                  });
                                },
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: 12,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 3, right: 0),
                                  margin: EdgeInsets.only(left: 10),
                                  color: Colors.white,
                                  child: Text(
                                    'End Date: ',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.65)),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  )),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Create"),
                  onPressed: () async {
                    boardTitle = titleController.text;
                    if (_formKey.currentState.validate()) {
                      Project_Board projectBoard = new Project_Board();
                      Project_BoardController projectBoardController =
                      new Project_BoardController();
                      projectBoard.Project_Title = titleController.text;
                      projectBoard.Project_Description = descriptionController.text;
                      projectBoard.Project_StartDate = _startDate;
                      projectBoard.Project_EndDate = _endDate;
                      //print("Person: "+personNo);
                      await projectBoardController.createBoard(projectBoard,user.userTypeID,personNo);
                      user.boards=await projectBoardController.ReadBoards(user.userTypeID, personNo);
                      projectBoard=user.boards.last;
                      addDynamic(projectBoard);
                      boardTitle = "";
                      await homePage.initializeDisplay();
                      Navigator.popAndPushNamed(context, '/Home');
                      setState(() {

                      });
                    }
                  },
                )
              ],
            );
          });
        });
  }

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic(Project_Board givenBoard) {
    listDynamic.add(new DynamicWidget(aboard: givenBoard));
  }

  signout() {
    degrees.clear();
    studentTypes.clear();
    listDynamic.clear();

    user = new User();
    supervisor = new Supervisor();
    student = new Student();
    //project_board=new Project_Board();
    studentController = new StudentController();
    supervisorController = new SupervisorController();
    userController = new UserController();
    //project_boardController=new Project_BoardController();
    Navigator.popAndPushNamed(context, '/Login');

//ProjectBoardView
    homePage = new HomePage();
  }

  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  @override
  Widget build(BuildContext context) {

    Widget dynamicTextField = new Container(
      margin: new EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    final plusButton = new Container(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
        onPressed: () async{
          await createAlertDialog(context);


        },
        color:
            //Colors.blueGrey
            Color(0xff009999),
        textColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
    );

    final arrowImage = Image.asset("assets/downarrow.png");

    final noBoardsView = new Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            alignment: Alignment.bottomCenter,
            child: Text(
              "Click the + button below to create a board.",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 100, top: 10),
            alignment: Alignment.bottomLeft,
            child: arrowImage,
          ),
        ],
      ),
    );

    return Scaffold(
      //
      appBar: AppBar(
        title: Text("Innovative Skyline"),
        backgroundColor: Color(0xff009999),
      ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: user.boards.length > 0 ? dynamicTextField : noBoardsView,
      ),
      floatingActionButton: plusButton,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
              decoration: BoxDecoration(
                color: Color(0xff009999),
              ),
            ),
            ListTile(
              title: Text('View Profile',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {

                if (user.userTypeID == 1) {
                  Navigator.popAndPushNamed(context, '/StudProfile');
                } else if (user.userTypeID == 2) {
//                  supervisorController.fetchSup(user.email);
//                  print('Navigate to View Supervisor Profile: ' +
//                      supervisor.staffNo);
                  Navigator.popAndPushNamed(context, '/SupProfile');
                } else {
                  print('User type not recognized');
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: Text('Sign Out',
                  style: TextStyle(
                      color: Color(0xff009999), fontWeight: FontWeight.bold)),
              onTap: () {
                signout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DynamicWidget extends StatefulWidget {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));
  //String giventitle='';
  Project_Board aboard;

  DynamicWidget({Key key, @required this.aboard}) : super(key: key);

  popLists() async {
    aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
  }

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}



class _DynamicWidgetState extends State<DynamicWidget> {

  // ignore: missing_return
  int getBoardIndex(int boardID) {
    //print("BOARD ID: "+boardID.toString());
    //print("getting board index ... ugh");
    for (int i = 0; i < user.boards.length; i++) {
      //print("looking...............");
      //print("Board ID: "+user.boards[i].ProjectID.toString()+" our ID: "+boardID.toString() );

      if (user.boards[i].ProjectID == boardID) {
        //print("BOARD INDEX: "+i.toString());
        return i;
      }
    }
  }
  bool _isShareDisabled=false;
  bool _isEditDisabled=false;
  determineAccess(){
    Project_Board pb=user.boards[getBoardIndex(widget.aboard.ProjectID)];
    if(pb.AccessLevel==null || pb.AccessLevel==1) {
      //Full admin
      _isShareDisabled = false;
      _isEditDisabled = false;
    }
    else if(pb.AccessLevel==2){
      //Can edit but not share
      _isShareDisabled = true;
      _isEditDisabled = false;
    }else if (pb.AccessLevel==3){
      //Can only view
      _isShareDisabled = true;
      _isEditDisabled = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    determineAccess();
    //widget.popLists();
    Project_BoardController projectBoardController = new Project_BoardController();
    TextEditingController descriptionController = new TextEditingController();
    // ignore: non_constant_identifier_names
    final Edit_formKey = GlobalKey<FormState>();
    //int userType=user.userTypeID;

    DateTime _startDate;
    DateTime _endDate;

    String startDateinput = "Select date ...";
    String endDateinput = "Select date ...";
    TextStyle datestyle = TextStyle(
        color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');
    // ignore: non_constant_identifier_names
    bool ChangedStart = false;
    // ignore: non_constant_identifier_names
    bool ChangedEnd = false;
    Future<Null> selectStartDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: new DateTime(2000),
          lastDate: new DateTime(2030));

      if (picked != null && picked != DateTime.now()) {
        setState(() {
          _startDate = picked;
          ChangedStart = true;
        });
      }
      datestyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');
      startDateinput = DateFormat('yyyy-MM-dd').format(_startDate);
    }

    Future<Null> selectEndDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: new DateTime(2000),
          lastDate: new DateTime(2030));

      if (picked != null && picked != DateTime.now()) {
        setState(() {
          _endDate = picked;
          ChangedEnd = true;
        });
      }
      datestyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');
      endDateinput = DateFormat('yyyy-MM-dd').format(_endDate);
    }

    // ignore: non_constant_identifier_names
    bool ChangedBoardValue=false;

    Future<String> confirmDeleteAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "CONFIRM DELETE ",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              content: Text(
                "Are you sure you want to delete this board?",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    int boardIndex;
                    for (int j=0;j<user.boards.length;j++){
                      if(user.boards[j].ProjectID==widget.aboard.ProjectID){
                        boardIndex=j;
                      }
                    }
                    await projectBoardController.deleteBoard(widget.aboard.ProjectID);


                    listDynamic.removeAt(boardIndex);
                    //user.boards.removeAt(boardIndex);
                    //homePage=new HomePage();
                    homePage.initializeDisplay();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => homePage),
                    );
                    setState(() {

                    });
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    Future<String> editBoardAlertDialog(BuildContext context) {
      TextEditingController titleController = new TextEditingController();
      descriptionController.text = widget.aboard.Project_Description;
      if (widget.aboard.Project_StartDate != null) {
        startDateinput =
            DateFormat('yyyy-MM-dd').format(widget.aboard.Project_StartDate);
      } else {
        startDateinput = "Select date ...";
      }
      if (widget.aboard.Project_EndDate != null) {
        endDateinput =
            DateFormat('yyyy-MM-dd').format(widget.aboard.Project_EndDate);
      } else {
        endDateinput = "Select date ...";
      }
      titleController.text = widget.aboard.Project_Title;

      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text(widget.aboard.Project_Title),
                content: Form(
                    key: Edit_formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text("Board Title:")),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                //hintText: "* Board Title",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0))),
                              onChanged: (val) {
                                ChangedBoardValue=true;
                                setState(() {

                                  widget.aboard.Project_Title = val;
                                  print('changing: '+widget.aboard.Project_Title);
                                });

                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child: Text("Description:")),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: descriptionController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                //hintText: "Description",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0))),
                              onChanged: (val) {
                                ChangedBoardValue=true;
                                setState(() =>
                                widget.aboard.Project_Description = val);
                              },
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                //padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                  shape: BoxShape.rectangle,
                                ),
                                child: MaterialButton(
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff009999),
                                        ),
                                        onPressed: () {},
                                        tooltip: "Select start date",
                                      ),
                                      Text(
                                        startDateinput,
                                        style: datestyle,
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await selectStartDate(context);
                                    setState(() {
                                      startDateinput = DateFormat('yyyy-MM-dd')
                                          .format(_startDate);
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 10,
                                  top: 12,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 10, left: 3, right: 0),
                                    margin: EdgeInsets.only(left: 10),
                                    color: Colors.white,
                                    child: Text(
                                      'Start Date:',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.65)),
                                    ),
                                  )),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                //padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                  shape: BoxShape.rectangle,
                                ),
                                child: MaterialButton(
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff009999),
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        tooltip: "Select end date",
                                      ),
                                      Text(
                                        endDateinput,
                                        style: datestyle,
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await selectEndDate(context);
                                    setState(() {
                                      endDateinput =
                                          DateFormat('yyyy-MM-dd').format(_endDate);
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 10,
                                  top: 12,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 10, left: 3, right: 0),
                                    margin: EdgeInsets.only(left: 10),
                                    color: Colors.white,
                                    child: Text(
                                      'End Date: ',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.65)),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                actions: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.bottomLeft,
                          //color: Colors.green,
                          width: MediaQuery.of(context).size.width/1.75,
                          child: MaterialButton(
                            elevation: 5.0,
                            child: Text("DELETE",style: TextStyle(color: Colors.red),),
                            onPressed: () async {
                              await confirmDeleteAlertDialog(context);
                            },
                          )),
                      Container(
                          alignment: Alignment.bottomRight,
                          //color: Colors.green,
                          child: MaterialButton(
                            elevation: 5.0,
                            child: Text("Ok"),
                            onPressed: () {
                              //boardTitle = titleController.text;
                              //print(widget.aboard.Project_Description);
                              if (Edit_formKey.currentState.validate()) {
                                if (ChangedStart == true) {
                                  widget.aboard.Project_StartDate =
                                      _startDate;
                                }
                                if (ChangedEnd == true) {
                                  widget.aboard.Project_EndDate =
                                      _endDate;
                                }
                                if(ChangedBoardValue==true||ChangedStart==true||ChangedEnd==true){
                                  projectBoardController
                                      .updateBoard(widget.aboard);
                                  print(widget.aboard.Project_Title);
                                }
                              }
                              Navigator.of(context).pop();
                            },
                          )),

                    ],
                  ),
                ],
              );
            });
          });
    }


    final listReturn = new Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(
          widget.aboard.Project_Title,
          style: widget.style,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.edit,
            color: _isEditDisabled==true? Colors.grey : Colors.black,),
          onPressed: _isEditDisabled==true? null : ()async {
            await editBoardAlertDialog(context);
            setState(() {

            });
          },
        ),
        onTap: () async {
          print("BOARD: "+widget.aboard.ProjectID.toString());
          await widget.popLists();
          print("LISTS IS NULL: "+(widget.aboard.boardLists==null).toString());
          //aboard.boardLists = await listController.ReadLists(aboard.ProjectID);
          Board boardPage = new Board(
            proj_board: widget.aboard,
          );
          await boardPage.populateListDisplay(widget.aboard.ProjectID);


          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => boardPage),
          );
        },
      ),
    );

    return listReturn;
  }
}
