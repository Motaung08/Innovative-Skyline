import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/DegreeType.dart';
import 'package:postgrad_tracker/main.dart';

class DegreeController {

/*
The purpose of this method is to fetch the different types of degrees stored.
This is so that upon student app registration, the student may select from a
pre-populated list of degree types such as Honours, masters by coursework, etc.
 */
    Future getDegrees({url='http://10.100.15.38/getDegreeTypes.php'}) async{
    //final response = await http.post("http://146.141.21.17/getDegreeTypes.php");
//    final response = await http.post(
//        //"https://witsinnovativeskyline.000webhostapp.com/getDegreeTypes.php"
//      "http://10.100.15.38/getDegreeTypes.php"
//      );

    //print('Assigning title for '+student.studentTypeID.toString());

    var result = json.decode(url);

    for (int i=0; i<result.length;i++){
      DegreeType degree=new DegreeType();
      degree.DegreeID=int.parse(result[i]['DegreeID']);
      degree.Degree_Type=result[i]['Degree_Type'];
      degrees.add(degree);
    }

  }

}



