import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Login.dart';
import 'package:postgrad_tracker/ViewStudentProfile.dart';

class HomePage extends StatelessWidget {
  //HomePage({Key key, this.title}) : super(key: key);
  final String email;
  final int userType;
  HomePage({this.email, this.userType});
  //final String title;

  @override

  Widget build(BuildContext context) {


    final ViewProfileButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if(userType==1 || userType==2){
            Navigator.pushNamed(context, '/StudProfile');
          } else if (userType==3){
            Navigator.pushNamed(context, '/SupProfile');
          }

          },
        child: Text("View Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final SignOutButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009999),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("Sign out",
            textAlign: TextAlign.center,
            style: TextStyle(
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
    final stud_name='';return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text("Innovative Skyline"),
        backgroundColor: Color(0xff009999),
        //elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async{
              //await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("logout")
          )
        ],
      ),
      body: Center(
          child: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //BackButton(),
                  SizedBox(height: 65.0, width: 500.0, child: ViewProfileButon),
                  SizedBox(height: 15.0),
                  SizedBox(height: 65.0, width: 500.0, child: SignOutButon),


                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
