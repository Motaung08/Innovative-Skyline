import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/Controller/AssignmentController.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/StudentController.dart';
import 'package:postgrad_tracker/Controller/SupervisorController.dart';
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Model/AssignmentType.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/Model/Task.dart';
import 'package:postgrad_tracker/Model/TaskStatus.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> stiles = new List<StaggeredTile>();
List<DynamicList> listDynamic = [];
// ignore: non_constant_identifier_names

// ignore: must_be_immutable
class Board extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Project_Board proj_board;
  // ignore: non_constant_identifier_names
  Board({Key key, this.proj_board}) : super(key: key);

  // ignore: non_constant_identifier_names
  Future populateListDisplay(int ProjectID) async {
    print('populateListDisplay() called');
    //lists = [];
    int boardIndex;
    // int testVal;
    void getIndexes() {
      for (int i = 0; i < user.boards.length; i++) {
        if (user.boards[i].ProjectID == ProjectID) {
          boardIndex = i;
        }
      }
    }

    getIndexes();
    // items.clear();
    user.boards[boardIndex].boardLists =
        await listController.ReadLists(ProjectID);

    if (user.boards[boardIndex].boardLists != null) {
      print('Initializing board\'s list display! ##################');
      stiles.clear();
      listDynamic.clear();
      int crossCount=kIsWeb==true?1:2;
      for (int i = 0; i < user.boards[boardIndex].boardLists.length; i++) {
        double mainAxis=0.5;
        for(int m=0;m<user.boards[boardIndex].boardLists[i].listTasks.length;m++){
          double addNum= kIsWeb==true? .225 : .52;
          mainAxis+=addNum;
        }
        DynamicList dynamicCreatedList =
            new DynamicList(aList: user.boards[boardIndex].boardLists[i]);

        listDynamic.add(dynamicCreatedList);

        stiles.add(StaggeredTile.count(
            1,kIsWeb==false?
        user.boards[boardIndex].boardLists[i].listTasks.length+1.3 :
        mainAxis));
      }
    }
  }

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {




  // ignore: missing_return, non_constant_identifier_names
  int getBoardIndex(int BoardID) {
    for (int i = 0; i < user.boards.length; i++) {
      if (user.boards[i].ProjectID == BoardID) {
        return i;
      }
    }
  }

  Future initializeAssignmentTypes () async {

    _dropdownAssignmentTypeMenuItems = buildDropdownAssignmentTypeMenuItems(_assignmentType);
    _selectedAssignmentType = _dropdownAssignmentTypeMenuItems[0].value;
    setState(() {

    });

  }

  List<AssignmentType> _assignmentType = assignmentTypes;
  List<DropdownMenuItem<AssignmentType>> _dropdownAssignmentTypeMenuItems;
  AssignmentType _selectedAssignmentType;

  List<DropdownMenuItem<AssignmentType>> buildDropdownAssignmentTypeMenuItems(List types) {
    List<DropdownMenuItem<AssignmentType>> items = List();
    for (AssignmentType type in types) {
      items.add(
        DropdownMenuItem(
          value: type,
          child: Text(type.assignmentTypeText, style: TextStyle(color: Colors.grey,fontFamily: 'Montserrat', fontSize: 20.0),overflow: TextOverflow.ellipsis,),

        ),
      );
    }
    return items;
  }

  onChangeAssignmentTypeDropdownItem(AssignmentType selectedType) {
    setState(() {
      _selectedAssignmentType = selectedType;
    });
  }


  void pop() {
    print("**POP**");
    stiles.clear();
    int boardIndex = getBoardIndex(widget.proj_board.ProjectID);

    listDynamic.clear();
    if (user.boards[boardIndex].boardLists != null) {

      for (int i = 0; i < user.boards[boardIndex].boardLists.length; i++) {
        double mainAxis=0.5;
        DynamicList dynamicCreatedList =
            new DynamicList(aList: user.boards[boardIndex].boardLists[i]);

        listDynamic.add(dynamicCreatedList);
        if (user.boards[boardIndex].boardLists[i].listTasks.length == 0) {
          stiles.add(StaggeredTile.count(1, kIsWeb==true? .8:1.5));
          //stiles.add(StaggeredTile.count(1, .8));
        } else {
          print("LENGTH: "+user.boards[boardIndex].boardLists[i].listTasks.length.toString());
          for(int m=0;m<user.boards[boardIndex].boardLists[i].listTasks.length;m++){
            double addNum= kIsWeb==true? .225 : .52;
            mainAxis+=addNum;

          }
          //mainAxis+=user.boards[boardIndex].boardLists[i].listTasks.length;
          stiles.add(
              StaggeredTile.count(
                  1
              ,
              mainAxis
          )
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initializeAssignmentTypes();
    //widget.populateListDisplay(widget.proj_board.ProjectID);
    pop();
  }

  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  String boardTitle = "";
  final _editFormKey = GlobalKey<FormState>();
  //int userType=user.userTypeID;

  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  String startDateinput = "Select date ...";
  String endDateinput = "Select date ...";
  TextStyle datestyle = TextStyle(
      color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');
  // ignore: non_constant_identifier_names
  bool ChangedStart = false;
  // ignore: non_constant_identifier_names
  bool ChangedEnd = false;
  // ignore: non_constant_identifier_names
  bool ChangedBoardValue;
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

  final _formKey = GlobalKey<FormState>();
  TextEditingController listTitle = new TextEditingController();
  final items = List();

  // ignore: non_constant_identifier_names
  Project_BoardController project_boardController =
      new Project_BoardController();

  Future<String> confirmBoardDeleteAlertDialog(BuildContext context) {
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
                  await project_boardController.deleteBoard(widget.proj_board.ProjectID);

                            //listDynamic.removeAt(boardIndex);
                            await homePage.initializeDisplay();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => homePage),
                            );
                            setState(() {});
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

  //Edit Board Popup
  Future<String> editBoardAlertDialog(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    descriptionController.text = widget.proj_board.Project_Description;
    if (widget.proj_board.Project_StartDate != null) {
      startDateinput =
          DateFormat('yyyy-MM-dd').format(widget.proj_board.Project_StartDate);
    } else {
      startDateinput = "Select date ...";
    }
    if (widget.proj_board.Project_EndDate != null) {
      endDateinput =
          DateFormat('yyyy-MM-dd').format(widget.proj_board.Project_EndDate);
    } else {
      endDateinput = "Select date ...";
    }
    titleController.text = widget.proj_board.Project_Title;
    if (widget.proj_board.Project_Title != null) {}
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(widget.proj_board.Project_Title),
              content: Form(
                  key: _editFormKey,
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
                              ChangedBoardValue = true;
                              setState(
                                  () => widget.proj_board.Project_Title = val);
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
                              ChangedBoardValue = true;
                              setState(() =>
                                  widget.proj_board.Project_Description = val);
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
                                onPressed: () {
                                  selectStartDate(context);
                                  startDateinput = DateFormat('yyyy-MM-dd')
                                      .format(_startDate);
                                  //startDateinput=_startDate.toString();
                                  setState(() {});
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
                                onPressed: () {
                                  selectEndDate(context);
                                  endDateinput =
                                      DateFormat('yyyy-MM-dd').format(_endDate);
                                  setState(() {});
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
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: MaterialButton(
                          elevation: 5.0,
                          child: Text(
                            "DELETE",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await confirmBoardDeleteAlertDialog(context);


                          },
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        //color: Colors.green,
                        child: MaterialButton(
                          elevation: 5.0,
                          child: Text("Ok"),
                          onPressed: () {
                            boardTitle = titleController.text;
                            //print(widget.proj_board.Project_Description);
                            if (_editFormKey.currentState.validate()) {
                              if (ChangedStart == true) {
                                widget.proj_board.Project_StartDate =
                                    _startDate;
                              }
                              if (ChangedEnd == true) {
                                widget.proj_board.Project_EndDate = _endDate;
                              }
                              if (ChangedBoardValue == true ||
                                  ChangedStart == true ||
                                  ChangedEnd == true) {
                                project_boardController
                                    .updateBoard(widget.proj_board);
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

  String newListTitle = "";
  //Create List Popup
  Future<String> createAlertDialog(BuildContext context) {
    listTitle.text = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("List title: "),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: listTitle,
                validator: (val) => val.isEmpty ? 'Enter a List Title' : null,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Create List"),
                onPressed: () async {
                  //listTitle.text = "";
                  if (_formKey.currentState.validate()) {
                    print('BEFORE LISTS: ' +
                        user.boards[getBoardIndex(widget.proj_board.ProjectID)]
                            .boardLists.length
                            .toString());
                    ListCard newList = new ListCard();
                    newList.List_Title = listTitle.text;
                    newList.ProjectID = widget.proj_board.ProjectID;
                    await listController.createList(newList);
                    user.boards[getBoardIndex(widget.proj_board.ProjectID)]
                            .boardLists =
                        await listController.ReadLists(
                            widget.proj_board.ProjectID);
                    print('AFTER LISTS: ' +
                        user.boards[getBoardIndex(widget.proj_board.ProjectID)]
                            .boardLists.length
                            .toString());
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String email;
  TextEditingController emailController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();

  bool _isShareDisabled=false;
  bool _isEditDisabled=false;
  determineAccess(){
    if(widget.proj_board.AccessLevel==null || widget.proj_board.AccessLevel==1) {
      //Full admin
      _isShareDisabled = false;
      _isEditDisabled = false;
    }
    else if(widget.proj_board.AccessLevel==2){
      //Can edit but not share
      _isShareDisabled = true;
      _isEditDisabled = false;
    }else if (widget.proj_board.AccessLevel==3){
      //Can only view
      _isShareDisabled = true;
      _isEditDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {

  determineAccess();
    final dropdownAssignmentType = new SizedBox(

      child:StatefulBuilder(
        builder: (context,setState){
          return  Container(
            // padding: EdgeInsets.symmetric(horizontal: 20) ,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),

            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  DropdownButton(
                    value: _selectedAssignmentType,
                    items: _dropdownAssignmentTypeMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedAssignmentType = value;
                      });
                    },
                    isExpanded: true,
                  ),

                  //Text('Selected: ${_selectedDegree.DegreeType}'),
                ],
              ),
            ),
          );
        },

      ),

    );

    Future<String> shareAlertDialog(BuildContext context) async {
      String foundUser = "";

      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("Share"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        key: _key,
                        child:Container(
                          alignment: Alignment.bottomLeft,
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(labelText: 'Email'),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => validateEmail(value),
                                maxLength: 32,
                                onEditingComplete: () {
                                  //Check if email exists

                                  //if there is time make it possible to add multiple
                                  //recipients here.
                                },
                                onChanged: (String val) {
                                  email = val;
                                },
                              ),
                              dropdownAssignmentType
                            ],
                          ),
                        ),
                      ),
                      Text(
                        foundUser,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("Share"),
                      onPressed: () async {
                        print("share with " + email);
                        if (_key.currentState.validate()) {
                          // No any error in validation

                          print("Email $email");

                          //check for users
                          bool exists = await userController.userExists(email);
                          if (exists == true) {
                            print('exists');
                            foundUser = "";
                            setState(() {});
                            // Add assignment now that it is valid.
                            User assignUser = await userController.getUser(email);
                            // ignore: non_constant_identifier_names
                            String OtherPersonNo;

                            if (assignUser.userTypeID == 1) {
                              StudentController studentController =
                              new StudentController();
                              Student assignStud =
                              await studentController.fetchStudent(email);
                              OtherPersonNo = assignStud.studentNo;
                            } else {
                              SupervisorController supervisorController =
                              new SupervisorController();
                              Supervisor assignSup =
                              await supervisorController.fetchSup(email);
                              OtherPersonNo = assignSup.staffNo;
                            }

                            AssignmentController assignmentController =
                            new AssignmentController();
                            print("SELECTED: "+_selectedAssignmentType.assignmentTypeText+" "+_selectedAssignmentType.assignmentTypeID.toString());
                            //COME BACK AND CHANGE ACCESSID!
                            await assignmentController.createAssignment(
                                assignUser.userTypeID,
                                OtherPersonNo,
                                widget.proj_board.ProjectID,
                                _selectedAssignmentType.assignmentTypeID);
                            Navigator.pop(context);
                          } else {
                            foundUser = "No such user found.";
                            setState(() {});
                          }
                        }
                      },
                    )
                  ],
                );
              },
            );
          });
    }

    //plus list
    final plusButton = new Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.all(1),
      child: MaterialButton(
        onPressed: () async {
          await createAlertDialog(context);
          pop();
          setState(() {});
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

    //This view should be displayed when it is determined that
    //The selected board has no lists to display.
    final noBoardsView = new Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            alignment: Alignment.center,
            child: Text(
              "Click the + button below to create a list.",
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

  final noBoardsNoEditView = new Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          alignment: Alignment.center,
          child: Text(
            "No lists created yet.",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
        ),
      ],
    ),
  );

    //Staggered lists view which we see for individual boards.
    final staggered = Container(
      margin: new EdgeInsets.all(10.0),
      // child:  SizedBox(
      //height: 505,
      child: SingleChildScrollView(
        child: StaggeredGridView.count(
          primary: false,
          addRepaintBoundaries: true,
          crossAxisCount: kIsWeb==false?2:MediaQuery.of(context).size.width<1200?2:4,
          shrinkWrap: true,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          children: listDynamic,
          staggeredTiles: stiles,
        ),
      ),
      //)
    );



    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: IconButton(
              disabledColor: Colors.grey,
              icon: Icon(
                Icons.edit,
                color: _isEditDisabled==true? Colors.grey : Colors.black,
              ),
              onPressed:_isEditDisabled==true? null : () {
                editBoardAlertDialog(context);
              },
            ),
          ),
          IconButton(
            disabledColor: Colors.grey,
            icon: Icon(
              Icons.share,
              color: _isShareDisabled==true? Colors.grey : Colors.black,
            ),
            onPressed: _isShareDisabled==true? null : () {
              //print("SHARE");
              shareAlertDialog(context);
              //Share.share(widget.proj_board.Project_Title);
            },
          )
        ],
        title: Text(widget.proj_board.Project_Title),
        backgroundColor: Color(0xff009999),
      ),
      backgroundColor: Colors.grey,
      body: (
          user.boards[getBoardIndex(widget.proj_board.ProjectID)].boardLists.length!=0
          )
          ? staggered
          : _isEditDisabled==true? noBoardsNoEditView : noBoardsView,
      floatingActionButton: _isEditDisabled==true? null : plusButton,
      //bottomSheet: plusButton,
    );
  }
}

class Constants {
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';
  //static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    Edit,
    Delete,
    //SignOut
  ];
}

// ignore: must_be_immutable
class DynamicList extends StatefulWidget {
  ListCard aList;

  DynamicList({Key key, @required this.aList}) : super(key: key);

  int boardIndex;
  int listIndex;
  void getIndex() {
    for (int i = 0; i < user.boards.length; i++) {
      if (user.boards[i].ProjectID == aList.ProjectID) {
        boardIndex = i;
        for (int j = 0; j < user.boards[i].boardLists.length; j++) {
          if (user.boards[i].boardLists[j].ListID == aList.ListID) {
            listIndex = j;
          }
        }
      }
    }
  }

  Future initializeTaskDisplay() async {
    getIndex();
    user.boards[boardIndex].boardLists[listIndex].listTasks =
        await taskController.ReadTasks(aList.ListID);
  }

  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));

  List<DropdownMenuItem<TaskStatus>> _dropdownTaskStatusMenuItems;
  TaskStatus _selectedTaskStatus;

  List<DropdownMenuItem<TaskStatus>> buildDropdownTaskStatusMenuItems(
      List types) {
    List<DropdownMenuItem<TaskStatus>> items = List();
    for (TaskStatus type in types) {
      items.add(
        DropdownMenuItem(
          value: type,
          child: Text(
            type.Status,
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Montserrat', fontSize: 20.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return items;
  }

  onChangeTaskStatusDropdownItem(TaskStatus selectedStatus) {
    setState(() {
      _selectedTaskStatus = selectedStatus;
    });
  }

  initializeTaskStatus() {
    _dropdownTaskStatusMenuItems =
        buildDropdownTaskStatusMenuItems(taskStatuses);

    _selectedTaskStatus = taskStatuses[0];

    setState(() {});
  }

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

  // ignore: missing_return
  int getListIndex(int listID) {
    for (int j = 0;
    j <
        user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists
            .length;
    j++) {
      if (user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists[j]
          .ListID ==
          listID) {
        return j;
      }
    }
  }

  // ignore: missing_return
  int getTaskStatusIndex(int statusID) {
    for (int j = 0; j < taskStatuses.length; j++) {
      if (taskStatuses[j].TaskStatusID == statusID) {
        return j;
      }
    }
  }

  // ignore: missing_return, non_constant_identifier_names
  int getTaskIndex(int TaskID) {
    for (int j = 0;
    j <
        user
            .boards[getBoardIndex(widget.aList.ProjectID)]
            .boardLists[getListIndex(widget.aList.ListID)]
            .listTasks
            .length;
    j++) {
      if (user
          .boards[getBoardIndex(widget.aList.ProjectID)]
          .boardLists[getListIndex(widget.aList.ListID)]
          .listTasks[j]
          .TaskID ==
          TaskID) {
        return j;
      }
    }
  }

  bool _isShareDisabled=false;
  bool _isEditDisabled=false;
  determineAccess(){
    Project_Board pb=user.boards[getBoardIndex(widget.aList.ProjectID)];
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
    // ignore: missing_return


    // ignore: non_constant_identifier_names
    final EditorKey = GlobalKey<FormState>();
    final titleEditorKey = GlobalKey<FormState>();

    DateTime _dueDate = new DateTime.now();
    bool dueChanged = false;
    String dueDateInput = "Select date ...";
    TextStyle dateStyle = TextStyle(
        color: Colors.black.withOpacity(0.65), fontFamily: 'Montserrat');

    Future<Null> selectDueDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: new DateTime(2000),
          lastDate: new DateTime(2030));

      if (picked != null) {
        setState(() {
          _dueDate = picked;
          dueChanged = true;
        });
      }
      dateStyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat');

      dueDateInput = DateFormat('yyyy-MM-dd').format(_dueDate);
    }

    int _selectedTaskID;
    // ignore: non_constant_identifier_names
    bool ChangedTask = false;

    Future<String> confirmTaskDeleteAlertDialog(BuildContext context) {
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
                "Are you sure you want to delete this task?",
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
                    print("DELETE TASK: " +
                        _selectedTaskID.toString());
                    int send = _selectedTaskID;
                    await taskController.deleteTask(send);

                    setState(() {});
                    Navigator.of(context).pop();
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

    /*
    The following is the popup for creation, update and deletion of a task.
    Which of these 3 will depend on the create variable and user selection
    - i.e. if the user selects the add task button, this will be invoked and
    a create popup will be shown but if a user selects an already created task
    the user will be shown the details of the task as well as the option
    to update such details or to delete the task.
     */
    Future<String> createTaskAlertDialog(BuildContext context, bool create) {
      ChangedTask = false;
      TextEditingController titleController = new TextEditingController();
      TextEditingController descriptionController = new TextEditingController();

      TaskController taskController = new TaskController();
      Task newTask = new Task();

      if (create == false) {
        //i.e. to View/Edit the Task

        newTask = user
            .boards[getBoardIndex(widget.aList.ProjectID)]
            .boardLists[getListIndex(widget.aList.ListID)]
            .listTasks[getTaskIndex(_selectedTaskID)];

        titleController.text = newTask.Task_Title;
        descriptionController.text = newTask.Task_Description;
        _selectedTaskStatus =
            taskStatuses[getTaskStatusIndex(newTask.Task_StatusID)];

        if (newTask.Task_Due != null) {
          _dueDate = newTask.Task_Due;
          dueDateInput = DateFormat("yyyy-MM-dd").format(_dueDate);
        }
      } else {
        titleController.text = "";
        descriptionController.text = "";
        _selectedTaskStatus = taskStatuses[0];
        _dueDate = null;
        dueDateInput = "Select date ...";
      }

      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: create == true
                      ? Text("New Task: ")
                      : Text(user
                          .boards[getBoardIndex(widget.aList.ProjectID)]
                          .boardLists[getListIndex(widget.aList.ListID)]
                          .listTasks[getTaskIndex(_selectedTaskID)]
                          .Task_Title),
                  content: Container(
                    child: Form(
                      key: EditorKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //Title
                            TextFormField(
                              enabled: _isEditDisabled==true?false:true,
                              controller: titleController,
                              style: style.copyWith(color: Colors.black),
                              obscureText: false,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Task Title' : null,
                              onChanged: (val) {
                                //user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists[getListIndex(widget.aList.ListID)].listTasks[getListIndex(widget.aList.ListID)].Task_Title = val;

                                setState(() {
                                  newTask.Task_Title = val;
                                  ChangedTask = true;
                                });
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "* Title",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //Description
                            TextFormField(
                              enabled:
                              _isEditDisabled==true?false:
                              true,
                              controller: descriptionController,
                              style: style.copyWith(color: Colors.black),
                              maxLines: 5,
                              obscureText: false,
                              //validator: (val) => val.isEmpty ? 'Enter Task Title' : null,
                              onChanged: (val) {
                                newTask.Task_Description = val;
                                ChangedTask = true;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Description",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //Status

                            IgnorePointer(
                              ignoring: _isEditDisabled==true?true:false,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      DropdownButton(
                                        value:  _selectedTaskStatus,
                                        items:  _dropdownTaskStatusMenuItems,
                                        onChanged:  (value) {
                                          ChangedTask = true;
                                          setState(() {
                                            _selectedTaskStatus = value;
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //Due
                            IgnorePointer(
                              ignoring: _isEditDisabled==true?true:false,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                      width: double.infinity,
                                      height: 60,
                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      //padding: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
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
                                              //tooltip: "Select start date",
                                            ),
                                            Text(
                                              dueDateInput,
                                              style: dateStyle,
                                            ),
                                          ],
                                        ),
                                        onPressed:
                                        _isEditDisabled==true?null :
                                            () async {
                                          await selectDueDate(context);
                                          setState(() {
                                            dueDateInput =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(_dueDate);
                                            ChangedTask = true;
                                          });
                                        },
                                      )),
                                  Positioned(
                                      left: 10,
                                      top: 12,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 10, left: 3, right: 0),
                                        margin: EdgeInsets.only(left: 10),
                                        color: Colors.white,
                                        child: Text(
                                          'Due Date:',
                                          style: TextStyle(
                                              color:
                                              Colors.black.withOpacity(.65)),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    create == true
                        ? MaterialButton(
                            elevation: 5.0,
                            child: Text("Create"),
                            onPressed: () async {
                              if (EditorKey.currentState.validate()) {
                                newTask.Task_Title = titleController.text;
                                newTask.Task_Description =
                                    descriptionController.text;
                                newTask.ListID = widget.aList.ListID;
                                newTask.Task_AddedBy = personNo;

                                //NB COME BACK AND CHANGE THIS!
                                newTask.Task_StatusID =
                                    _selectedTaskStatus.TaskStatusID;

                                newTask.Task_DateAdded = DateTime.now();

                                //NB COME BACK AND CHANGE!
                                //newTask.Task_Due=DateTime.parse(dueController.text);
                                //newTask.Task_Due = DateTime.parse("2020-02-02");
                                if (dueChanged == true) {
                                  newTask.Task_Due = _dueDate;
                                }
//                                print("Title: " +
//                                    newTask.Task_Title +
//                                    "\n" +
//                                    "Description: " +
//                                    newTask.Task_Description +
//                                    "\n" +
//                                    "ListID: " +
//                                    newTask.ListID.toString() +
//                                    "\n" +
//                                    "Added by: " +
//                                    newTask.Task_AddedBy +
//                                    "\n" +
//                                    "Status ID: " +
//                                    newTask.Task_StatusID.toString() +
//                                    "\n" +
//                                    "Date added: " +
//                                    newTask.Task_DateAdded.toString() +
//                                    "\n" +
//                                    "Date Due: " +
//                                    newTask.Task_Due.toString());
                                await taskController.createTask(newTask);
                                widget.initializeTaskDisplay();
                                stiles[getListIndex(widget.aList.ListID)] =
                                    new StaggeredTile.count(
                                        kIsWeb==true?1:
                                        2,
                                        stiles[getListIndex(
                                                    widget.aList.ListID)]
                                                .mainAxisCellCount +
                                            .225);
                                Navigator.of(context).pop();
                              }


                            },
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IgnorePointer(
                                ignoring: _isEditDisabled==true?true:false,
                                child: Container(
                                    alignment: Alignment.bottomLeft,
                                    //color: Colors.green,
                                    width:
                                    MediaQuery.of(context).size.width / 1.75,
                                    child: MaterialButton(
                                      elevation: 5.0,
                                      child: Text(
                                        "DELETE",
                                        style: _isEditDisabled==true?TextStyle(color:Colors.grey):TextStyle(color: Colors.red),
                                      ),
                                      onPressed: _isEditDisabled==true? null : () async {
                                        await confirmTaskDeleteAlertDialog(context);
                                        Navigator.of(context).pop();
                                      },
                                    )),
                              ),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  //color: Colors.green,
                                  child: MaterialButton(
                                    elevation: 5.0,
                                    child: Text("Ok"),
                                    onPressed: () {
                                      //boardTitle = titleController.text;
                                      //print(widget.aboard.Project_Description);
                                      if (EditorKey.currentState.validate()) {
                                        if (dueChanged == true) {
                                          newTask.Task_Due = _dueDate;
                                        }
                                        newTask.Task_StatusID =
                                            _selectedTaskStatus.TaskStatusID;
                                        //newTask.Task_Title=titleController.text;
                                        //taskController.updateTask(newTask);
                                        if (ChangedTask == true) {
                                          print("Update task");
                                          taskController.updateTask(newTask);
                                        }
                                      }
                                      newTask = new Task();
                                      titleController.text = "";
                                      descriptionController.text = "";
                                      _selectedTaskStatus = taskStatuses[0];
                                      _dueDate = DateTime.now();
                                      dueDateInput = "Select date ...";
                                      Navigator.of(context).pop();
                                    },
                                  )),
                            ],
                          ),
                  ],
                );
              },
            );
          });
    }

    Future<String> editListAlertDialog(BuildContext context) {
      TextEditingController titleController = new TextEditingController();
      titleController.text = widget.aList.List_Title;

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Edit title: "),
              content: Form(
                key: titleEditorKey,
                child: TextFormField(
                  controller: titleController,
                  validator: (val) => val.isEmpty ? 'Enter a Title' : null,
                  onChanged: (val) {
                    setState(() => widget.aList.List_Title = val);
                  },
                  style: style.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                      //hintText: "Student Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Save"),
                  onPressed: () {
                    if (titleEditorKey.currentState.validate()) {
                      widget.aList.List_Title = titleController.text;
                      listController.updateList(widget.aList);
                      //Navigator.of(context).pop(titleController.text.toString());
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            );
          });
    }



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
                "Are you sure you want to delete this list?",
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
                    print("LIST: " + widget.aList.ListID.toString());
                    await listController.deleteList(widget.aList.ListID);
                    //user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists=await listController.ReadLists(widget.aList.ProjectID);
                    Navigator.pop(context);
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

    final addTaskButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999).withOpacity(0.65),

      //Color(0xff009999),
      child: MaterialButton(
          //minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            initializeTaskStatus();

            await createTaskAlertDialog(context, true);
            // await boardPage.populateListDisplay(widget.aList.ProjectID);
            await widget.initializeTaskDisplay();
            setState(() {});
            //Navigator.popAndPushNamed(context, '/Board');
          },
          key: Key('ListInput'),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text("Add Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          )),
    );

    // ignore: non_constant_identifier_names
    final TaskContainer = new Expanded(
        flex: 1,
        child: ListView.builder(
          itemCount: user.boards[getBoardIndex(widget.aList.ProjectID)]
              .boardLists[getListIndex(widget.aList.ListID)].listTasks.length,
          // ignore: non_constant_identifier_names
          itemBuilder: (BuildContext Context, int index) {
            return new Container(
              margin: EdgeInsets.all(4),
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff009999).withOpacity(0.1),
                //color:Colors.green,
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xff009999),
                    //color: Colors.red
                    //blurRadius: 10.0,
                    //offset: Offset(1.0,0.0)
                  ),
                ],

                //border: Border.all(color: Colors.white, width: 8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              //color: Color(0xff009999),
                              color: user
                                          .boards[getBoardIndex(
                                              widget.aList.ProjectID)]
                                          .boardLists[
                                              getListIndex(widget.aList.ListID)]
                                          .listTasks[index]
                                          .Task_StatusID ==
                                      4
                                  ? Colors.grey
                                  : user
                                              .boards[getBoardIndex(
                                                  widget.aList.ProjectID)]
                                              .boardLists[getListIndex(
                                                  widget.aList.ListID)]
                                              .listTasks[index]
                                              .Task_StatusID ==
                                          1
                                      ? Color(0xff009999)
                                      : Colors.green,
                              width: 5.0))),
                  child: ListTile(
                    title: Text(user
                        .boards[getBoardIndex(widget.aList.ProjectID)]
                        .boardLists[getListIndex(widget.aList.ListID)]
                        .listTasks[index]
                        .Task_Title,
                      style: user
                          .boards[getBoardIndex(
                          widget.aList.ProjectID)]
                          .boardLists[
                      getListIndex(widget.aList.ListID)]
                          .listTasks[index]
                          .Task_StatusID ==
                          4? TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)
                          : TextStyle(color: Colors.black)
                      ,
                    ),
                    onTap: () async {
                      _selectedTaskID = user
                          .boards[getBoardIndex(widget.aList.ProjectID)]
                          .boardLists[getListIndex(widget.aList.ListID)]
                          .listTasks[index]
                          .TaskID;
                      initializeTaskStatus();
                      //print("Current tasks: "+user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists[getListIndex(widget.aList.ListID)].listTasks.length.toString());
                      await createTaskAlertDialog(context, false);
                      await widget.initializeTaskDisplay();
                      Board boardPage = new Board(
                        proj_board:
                            user.boards[getBoardIndex(widget.aList.ProjectID)],
                      );
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => boardPage),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          shrinkWrap: true,
        )
    );

    Widget titleView = Container(
      //width: MediaQuery.of(context).size.width / 4,
      child: Text(widget.aList.List_Title,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
    );

    Future choiceAction(String choice) async {
      if (choice == Constants.Edit) {
        //print(widget.aList.ListID);
        await editListAlertDialog(context);
        setState(() {});
      } else if (choice == Constants.Delete) {
        await confirmDeleteAlertDialog(context);
        user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists =
            await listController.ReadLists(widget.aList.ProjectID);
        Board boardPage = new Board(
          proj_board: user.boards[getBoardIndex(widget.aList.ProjectID)],
        );
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => boardPage),
        );
      }
    }

    // ignore: non_constant_identifier_names
    final BoardItem = Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: new EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleView,
                PopupMenuButton<String>(
                  enabled: _isEditDisabled==true?false:true,
                  onSelected: _isEditDisabled==true? null : choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: choice != "Delete"
                            ? Text(choice)
                            : Text(
                                choice,
                                style: TextStyle(color: Colors.red),
                              ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            TaskContainer,
            _isEditDisabled==false? addTaskButton : SizedBox(height:1),
          ]),
    );

    return BoardItem;
  }
}
