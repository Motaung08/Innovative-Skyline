import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/StudentType.dart';
import 'package:postgrad_tracker/main.dart';

class StudentTypeController{

  /*
  This method should retrieve the different types of possible students so that
  upon registration, a student may select from a pre-populated list, which type
  of student they are. This is a type of future-proofing for when there may be
  more types of students such as full-time foreign students, part-time foreign
  students, disability students, etc, which may need to behave differently.
   */
  Future getTypes() async{
    //print('I am called');
//    final response = await http.post("http://146.141.21.17/getStudentTypes.php");
    final response = await http.post(
      "http://10.100.15.38/getStudentTypes.php"
//        "https://witsinnovativeskyline.000webhostapp.com/getStudentTypes.php"
    );

    //print('Assigning title for '+student.studentTypeID.toString());

    var result = json.decode(response.body);

    for (int i=0; i<result.length;i++){
      StudentType studentType = new StudentType();
      studentType.StudentTypeID=int.parse(result[i]['StudentTypeID']);
      studentType.Student_Type=result[i]['Student_Type'];
      studentTypes.add(studentType);
    }


  }

}
