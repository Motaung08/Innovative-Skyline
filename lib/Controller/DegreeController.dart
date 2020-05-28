import 'dart:convert';
import 'package:mockito/mockito.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/DegreeType.dart';
import 'package:postgrad_tracker/main.dart';

class DegreeController extends StatefulWidget {

/*
The purpose of this method is to fetch the different types of degrees stored.
This is so that upon student app registration, the student may select from a
pre-populated list of degree types such as Honours, masters by coursework, etc.
 */
    Future<bool>getDegrees() async{
     bool success=false;

    //final response = await http.post("http://146.141.21.17/getDegreeTypes.php");
    final response = await http.post("https://witsinnovativeskyline.000webhostapp.com/getDegreeTypes.php");

    //print('Assigning title for '+student.studentTypeID.toString());

    var result = json.decode(response.body);

    for (int i=0; i<result.length;i++){
      DegreeType degree=new DegreeType();
      degree.DegreeID=int.parse(result[i]['DegreeID']);
      degree.Degree_Type=result[i]['Degree_Type'];
      degrees.add(degree);
      //print(degree.Degree_Type);
    }

    if(degrees!=null){
      success=true;
    }

    return success;

  }

  @override
  _DegreeControllerState createState() => _DegreeControllerState();
}

class MockDegreeController extends DegreeController implements Mock{}

class _DegreeControllerState extends State<DegreeController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
