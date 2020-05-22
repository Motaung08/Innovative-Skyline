import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:postgrad_tracker/Model/Project_Board.dart';
import 'package:postgrad_tracker/Model/Task.dart';
import 'package:postgrad_tracker/main.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


List<StaggeredTile> stiles =new List<StaggeredTile>();
List<DynamicList> listDynamic = [];
int BoardIdentificationIndex;

// ignore: must_be_immutable
>>>>>>> 66e232c3fa6d5eccb27b9ad6a5ea42de4719037c
class Board extends StatefulWidget {
  //final String title;
  // ignore: non_constant_identifier_names
  final Project_Board proj_board;

  final items = List();
  // ignore: non_constant_identifier_names
  Board({Key key, this.proj_board}) : super(key: key);

  // ignore: non_constant_identifier_names



 TaskController taskController=new TaskController();

  // ignore: non_constant_identifier_names

  Future populateListDisplay(int ProjectID) async {
    //lists = [];
    int boardIndex;
    int listIndex;
    int testVal;
    void getIndexes(){
      for(int i=0;i<user.boards.length;i++){
        if(user.boards[i].ProjectID==ProjectID){
          boardIndex=i;
          BoardIdentificationIndex=i;
          for (int j=0;j<user.boards[i].boardLists.length;j++){
            if(user.boards[i].boardLists[j]==testVal){
              testVal=j;
            }
          }
        }
      }
    }
    getIndexes();
    items.clear();


    if(user.boards[boardIndex].boardLists!=null){
      print('Initializing list display! ##################');
      stiles.clear();
      for (int i = 0; i < user.boards[boardIndex].boardLists.length; i++) {
        // ListCard lsc=new ListCard();
        //lsc.List_Title="lsc test";
        DynamicList dynamicCreatedList=new DynamicList(aList: user.boards[boardIndex].boardLists[i]);
        //await dynamicCreatedList.initializeTaskDisplay();
        listDynamic.add(dynamicCreatedList);
       // user.boards[boardIndex].boardLists[i].listTasks.clear();
        //await taskController.ReadTasks(testVal);
        //items.add(listDynamic[i]);
        print(i);
        print('adding stiles for: StaggeredTile.count('+(2).toString()+","+(user.boards[boardIndex].boardLists[i].listTasks.length+2).toString()+")");
        stiles.add(
            StaggeredTile.count(2, user.boards[boardIndex].boardLists[i].listTasks.length+1.5));
      }
      //print("STILES"+stiles.length.toString());

    }


  }

  @override
  _BoardState createState() => _BoardState();
}





class _BoardState extends State<Board> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController listTitle = new TextEditingController();
  final items = List();
  // ignore: non_constant_identifier_names
  Project_BoardController project_boardController=new Project_BoardController();

  Future<String> editBoardAlertDialog(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    titleController.text = widget.proj_board.Project_Title;
    String title = "";
    if (widget.proj_board.Project_Title != null) {
      title = widget.proj_board.Project_Title;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit title: "),
            content: TextFormField(
              controller: titleController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Save"),
                onPressed: () {
                  widget.proj_board.Project_Title = titleController.text;
                  project_boardController.updateBoard(widget.proj_board);


                  //Navigator.of(context).pop(titleController.text.toString());
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    //listTitle.text="Enter list title ...";

    final addListButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          //if (_formKey.currentState.validate()) {
          if(_formKey.currentState.validate()){
            ListCard newList = new ListCard();
            newList.List_Title=listTitle.text;
            newList.ProjectID=widget.proj_board.ProjectID;
            listController.createList(newList);
            //widget.populateListDisplay(widget.proj_board.ProjectID);
            listDynamic.add(new DynamicList(aList: newList));
            setState(() {});
          }



        },
        key: Key('ListInput'),
        child: Text("Add list",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

//    final ListCardItem = new Container(
//      //width: MediaQuery.of(context).size.width/2,
//      decoration: BoxDecoration(
//        color: Colors.white,
//        border: Border.all(color: Colors.white, width: 8),
//        borderRadius: BorderRadius.circular(12),
//      ),
//      child: Form(
//        key: _formKey,
//        child: Column(children: <Widget>[
//          TextFormField(
//            controller: listTitle,
//            decoration: InputDecoration(
//                fillColor: Colors.white, hintText: "Enter list title..."),
//          ),
//          SizedBox(
//            height: 20,
//          ),
//          addListButton,
//        ]),
//      ),
//    );
//    items.add(ListCardItem);

    final addListCard = GridTile(
      child: Container(
        margin: new EdgeInsets.all(5.0),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: listTitle,
                  textDirection: TextDirection.ltr,
//                  onChanged: (val) {
//                    setState(() => listTitle.text = val);
//                  },
                  validator: (val) => val.isEmpty ? 'Enter list title.' : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white, hintText: "Enter list title..."),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              addListButton,
            ]),
      ),
    );

    Widget dynamicLists = new Flexible(
      flex: 2,
      child: new GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
        //itemBuilder: (_, index) => widget.listDynamic[index],
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new GridTile(child: items[index]),
          );
        },
      ),
    );

    List<Widget> testList = List<Widget>();

    void pop() {
      testList.clear();
      stiles.clear();
      int boardIndex;

      for(int i=0;i<user.boards.length;i++){
        if(user.boards[i].ProjectID==widget.proj_board.ProjectID){
          boardIndex=i;
          BoardIdentificationIndex=i;
        }
      }


      if(user.boards[boardIndex].boardLists!=null){
        print('Initializing list display! ##################');
        stiles.clear();
        for (int i = 0; i < user.boards[boardIndex].boardLists.length; i++) {
          testList.add(listDynamic[i]);
          stiles.add(StaggeredTile.count(2, user.boards[0].boardLists[i].listTasks.length+1.5));
        }
        //print("STILES"+stiles.length.toString());

      }

      testList.add(addListCard);
      stiles.add(StaggeredTile.count(2, 2));
      print("testList: "+testList.length.toString());
      print(" stiles: "+stiles.length.toString());


    }



    pop();
    print("STILES: "+stiles.length.toString());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  editBoardAlertDialog(context);
                },
              ),
            ),
          )
        ],
        title: Text(widget.proj_board.Project_Title),
        backgroundColor: Color(0xff009999),
      ),
      backgroundColor: Colors.grey,
      body: Container(
          margin: new EdgeInsets.all(10.0),
          child:  SingleChildScrollView(
            child: StaggeredGridView.count(
              primary: false,
              crossAxisCount: 4,
              shrinkWrap: true,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: testList,
              staggeredTiles: stiles,
            ),
          )
      ),
    );
  }
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

  List<Task> thisListTasks = [];

  Future initializeTaskDisplay() async{
    getIndex();

    if(user.boards[boardIndex].boardLists[listIndex].listTasks!=null){
      print('Initializing task display! ##################');
      thisListTasks=[];

      for(int i=0;i<user.boards[boardIndex].boardLists[listIndex].listTasks.length;i++){
        thisListTasks.add(user.boards[boardIndex].boardLists[listIndex].listTasks[i]);
      }


    }


  }

  @override
  _DynamicListState createState() => _DynamicListState();
}
/*
  class DynamicList extends StatefulWidget {
  @override
  _DynamicListState createState() => _DynamicListState();
}
class _DynamicListState extends State<DynamicList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
   */

class _DynamicListState extends State<DynamicList> {

  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: (Colors.white));

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    //widget.initializeTaskDisplay();

    int getBoardIndex(int boardID)  {
      int boardIndex;
      //print("BOARD ID: "+boardID.toString());
      //print("getting board index ... ugh");
      for (int i = 0; i < user.boards.length; i++) {
        //print("looking...............");
        //print("Board ID: "+user.boards[i].ProjectID.toString()+" our ID: "+boardID.toString() );

        if (user.boards[i].ProjectID == boardID) {

          boardIndex = i;
          print("UGH NOW? "+i.toString());
          return i;

        }
      }
    }


    int getListIndex(int listID)  {
      int listIndex;
      int boardIndex;
      for (int j = 0; j < user.boards[BoardIdentificationIndex].boardLists.length; j++) {
        if (user.boards[BoardIdentificationIndex].boardLists[j].ListID == listID) {
          listIndex = j;
          return j;
        }
      }
    }





    Future<String> createTaskAlertDialog(BuildContext context)  {
      TextEditingController titleController = new TextEditingController();
      TextEditingController descriptionController = new TextEditingController();

      //THIS MUST CHANGE TO DATETIME PICKER!
      TextEditingController dueController = new TextEditingController();
      TextEditingController statusController = new TextEditingController();


      TaskController taskController = new TaskController();
      Task newTask = new Task();




      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog (
              title: Text("New Task: "),
              content: Container(

                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        //Title
                        TextFormField(
                          controller: titleController,
                          style: style.copyWith(color: Colors.black),
                          obscureText: false,
                          validator: (val) =>
                          val.isEmpty
                              ? 'Enter Task Title'
                              : null,
                          onChanged: (val) {
                            newTask.Task_Title = val;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              hintText: "* Title",
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Description
                        TextFormField(
                          controller: descriptionController,
                          style: style.copyWith(color: Colors.black),
                          maxLines: 5,
                          obscureText: false,
                          //validator: (val) => val.isEmpty ? 'Enter Task Title' : null,
                          onChanged: (val) {
                            newTask.Task_Description = val;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              hintText: "Description",
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Status
                        TextFormField(
                          controller: statusController,
                          style: style.copyWith(color: Colors.black),
                          //maxLines: 5,
                          obscureText: false,
                          //validator: (val) => val.isEmpty ? 'Enter Task Title' : null,
                          onChanged: (val) {
                            newTask.Task_StatusID = int.parse(val);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              hintText: "Status",
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Due
                        TextFormField(
                          controller: dueController,
                          style: style.copyWith(color: Colors.black),
                          //maxLines: 5,
                          obscureText: false,
                          //validator: (val) => val.isEmpty ? 'Enter Task Title' : null,
                          onChanged: (val) {
                            newTask.Task_Due = DateTime.parse(val);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              hintText: "Date Due",
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Create"),
                  onPressed: () async{
                    newTask.Task_Title = titleController.text;
                    newTask.Task_Description = descriptionController.text;
                    newTask.ListID = widget.aList.ListID;
                    newTask.Task_AddedBy = personNo;

                    //NB COME BACK AND CHANGE THIS!
                    newTask.Task_StatusID = 1;

                    newTask.Task_DateAdded = DateTime.now();

                    //NB COME BACK AND CHANGE!
                    //newTask.Task_Due=DateTime.parse(dueController.text);
                    newTask.Task_Due = DateTime.parse("2020-02-02");
                    print("BEFORE: "+user.boards[BoardIdentificationIndex].boardLists[getListIndex(widget.aList.ListID)].listTasks.length.toString());
                    await taskController.createTask(newTask);
                    //widget.aList.listTasks.add(newTask);
                    user.boards[getBoardIndex(widget.aList.ProjectID)].boardLists[getListIndex(widget.aList.ListID)].listTasks.add(newTask);
                    stiles[getListIndex(widget.aList.ListID)]=new StaggeredTile.count(2,stiles[getListIndex(widget.aList.ListID)].mainAxisCellCount+1.5);
                    //aboard.boardLists = await listController.ReadLists(aboard.ProjectID);

//                    setState(() {
//
//                    });

                    Navigator.of(context).pop();
                  },
                )
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
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: ()  async{
            await createTaskAlertDialog(context);
            //print("PROJECT ID?!?!?: "+widget.aList.ProjectID.toString());
            boardPage = new Board(
              proj_board: user.boards[getBoardIndex(widget.aList.ProjectID)],
            );

            await boardPage.populateListDisplay(widget.aList.ProjectID);

            Navigator.popAndPushNamed(context, '/Board');
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (BuildContext context) => boardPage),
//            );
            setState(() {

            });
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

    final TaskContainer = new Expanded(
        flex: 1,
        child: ListView.builder
          (

          itemCount: widget.aList.listTasks.length,

          itemBuilder: (BuildContext ctxt, int index) {
            return new Container(
              margin: EdgeInsets.all(4),
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff009999).withOpacity(0.1),

                boxShadow: [
                  new BoxShadow(
                    color: Color(0xff009999),
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
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                ),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              color: Color(0xff009999),
                              width: 5.0
                          )
                      )
                  ),
                  child: ListTile(
                    title: Text(widget.aList.listTasks[index].Task_Title),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {

                      },
                    ),
                  ),
                ),
              ),
              //margin: EdgeInsets.all(3),
//              child:
            );
          },
          shrinkWrap: true,

        )
    );

    final BoardItem = Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
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
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 4,
                  child: Text(widget.aList.List_Title,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    //createAlertDialog(context);
                  },
                ),
              ],
            ),
            TaskContainer,


            addTaskButton,

          ]),
    );


    return BoardItem;
  }
}

