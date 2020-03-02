import 'package:flutter/material.dart';


class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

//    var user = firebase.auth().currentUser;
//
//    if (user != null) {
//      user.providerData.forEach(function (profile) {
//      console.log("Sign-in provider: " + profile.providerId);
//      console.log("  Provider-specific UID: " + profile.uid);
//      console.log("  Name: " + profile.displayName);
//      console.log("  Email: " + profile.email);
//      console.log("  Photo URL: " + profile.photoURL);
//      });
//    }

    final Name="test";

    final studentProfile = Container(
      //elevation: 5.0,
      //borderRadius: BorderRadius.circular(30.0),


      child: Column(

          children: <Widget>[
//                StreamBuilder(
//                  stream: Firestore.instance.collection('Student').snapshots(),
//                  builder: (context, snapshot){
//                    if (!snapshot.hasData) return const Text('Loading...');
//                    return Text("Name"+snapshot.data.documents[index]);
//                  },
//                ),
                Text("Profile:  \n",
                    //textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 24)
                ),


              Text(
                  "Name: "+Name+"\n",
                  //textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Student Number: "+"\n",
                  //textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
        Text(
                  "Email:"+"\n",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Degree:"+"\n",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                  "Date Registered:"+"\n",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Color(0xff009999), fontWeight: FontWeight.bold, fontSize: 18)
              )
        ]
      )
    );



    return Scaffold(
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

                    children: <Widget>[
                      SizedBox(child: studentProfile)
                    ],
                ),
              ),
            ),
          ],
      )),
    );
  }
}
