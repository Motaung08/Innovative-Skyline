import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Model/Assignment.dart';
import 'package:postgrad_tracker/Model/Student.dart';
import 'package:postgrad_tracker/Model/Supervisor.dart';
import 'package:postgrad_tracker/main.dart';

class AssignmentController {
  Assignment assignment;

  /*
  The purpose of this method is to share a board. This is done by taking in the
  appropriate arguments to write to the Assignment table in the database -
  with special mention of who the board is being shared with as this will be
  used to load the board upon their logging in.
   */
  // ignore: non_constant_identifier_names
  Future<String> createAssignment(int OtherUserType, String OtherPersonNo, int ProjectID, int AccessID,{url='http://10.100.15.38/createAssignment.php'}) async{

    var data={
      'UserTypeID' : OtherUserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
      'AccessLevelID' : AccessID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);

    return Response;
  }

  // ignore: non_constant_identifier_names
  Future<List> ReadAssignment(int UserType, String OtherPersonNo, int ProjectID,{url='http://10.100.15.38/ReadAssignment.php'}) async{

    var data={
      'UserTypeID' : UserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

    return Response;


  }

  // ignore: non_constant_identifier_names
  Future<List<List>> ReadBoardAssignments(int ProjectID,http.Client httpClient,{url='http://10.100.15.38/ReadBoardAssignments.php',
    url2="http://10.100.15.38/viewStudentStudNo.php",url3='http://10.100.15.38/viewSupStaffNo.php'}) async{
//    var url =
//        'https://witsinnovativeskyline.000webhostapp.com/ReadAssignment.php';

    var data={
      'ProjectID' : ProjectID.toString(),
    };
//    print("URL: "+url);
    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    String sudoResp= response.body;
    print(sudoResp);
    var Response = jsonDecode(response.body);
    print(Response);
    print("NULL? "+Response.length.toString());

    List<Supervisor> sharedSups=new List<Supervisor>();
    List<Student> sharedStudents=new List<Student>();
    List<List> sharedWith=new List<List>();
      for(int i=0;i<Response.length;i++){

        if(Response[i]["StudentNo"]!=null){
          //Assignment is for a student
          String studNo=Response[i]["StudentNo"];
          Student aStudent=new Student();
          //print("URL2: "+url2);
          aStudent = await studentController.fetchStudent(null, studNo,httpClient,urlViewStudentStudNo: url2);
          sharedStudents.add(aStudent);
        }
        else if(Response[i]["StaffNo"]!=null){
          //Assignment is for a supervisor
          String staffNo=Response[i]["StaffNo"];
          Supervisor aSupervisor=new Supervisor();
          aSupervisor=await supervisorController.fetchSup(null, staffNo,urlViewSupStaffNo: url3);
          sharedSups.add(aSupervisor);
        }
      }


    sharedWith.add(sharedStudents);
    sharedWith.add(sharedSups);
    print("SHARED WITH: "+sharedWith.length.toString());
    return sharedWith;


  }

  // ignore: non_constant_identifier_names
  Future<String> DeleteAssignment(int UserType, String OtherPersonNo, int ProjectID,{url='http://10.100.15.38/DeleteAssignment.php'}) async{
//    var url =
//        //'https://witsinnovativeskyline.000webhostapp.com/DeleteAssignment.php';
//    'http://10.100.15.38/DeleteAssignment.php';

    var data={
      'UserTypeID' : UserType.toString(),
      'AssignPerson' : OtherPersonNo.toLowerCase(),
      'ProjectID' : ProjectID.toString(),
    };

    // Starting Web API Call.
    var response = await http.post(url,body: jsonEncode(data));

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);

    return Response;


  }


}


