import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:postgrad_tracker/Controller/AssignmentTypeController.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/main.dart';

// ignore: must_be_immutable
class UserController{

  /*
  The purpose of the following method is to take in a User object and use the
  User values to create an instance in the User table in the database. This
  method also ensures no duplicate email is used.
   */
  Future<String> userRegistration(User userA,{url='http://10.100.15.38/register_user.php',url2='http://10.100.15.38/register_student.php'}) async {
    user.register = false;

    // SERVER API URL
//    var url =
//        'http://10.100.15.38/register_user.php';
////        'https://witsinnovativeskyline.000webhostapp.com/register_user.php';


    // Store all data with Param Name.
    var data = {
      'email': userA.email.toLowerCase(),
      'password': userA.password,
      'userType': userA.userTypeID};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      user.register=true;
      user.email=userA.email;
      user.password=userA.password;
      user.userTypeID=userA.userTypeID;
    }
    return message;
  }

  /*
  The purpose of the following method is to take in a User object and use the
  User values to remove the corresponding an instance in the User table in the
  database.
   */
  Future<String> userDeRegistration(User userA,{url='http://10.100.15.38/deregister_user.php'}) async {
    user.register = false;

    // SERVER API URL
//    var url =
//    'http://10.100.15.38/deregister_user.php';
////        'https://witsinnovativeskyline.000webhostapp.com/deregister_user.php';

    // Store all data with Param Name.
    var data = {
      'email': userA.email.toLowerCase(),
      'userType': userA.userTypeID
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    print(response.body);
    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    return message;
  }

  /*
  The following  method is used to determine whether a user may proceed to the
  home screen and if they may, then the home screen should be populated
  accordingly.
   */
  // ignore: non_constant_identifier_names
  Future<bool> login(String email, String Password,http.Client client,{
    urlLogin='http://10.100.15.38/login.php',
    urlGetTaskStatus:'http://10.100.15.38/getTaskStatuses.php',
    urlGetAssignmentTypes='http://10.100.15.38/getAssignmentTypes.php',
    urlGetStudTypes="http://10.100.15.38/getStudentTypes.php",
    urlViewStudentProfile='http://10.100.15.38/viewStudentProfile.php',
    urlViewStudentStudNo = "http://10.100.15.38/viewStudentStudNo.php",
    urlReadBoards='http://10.100.15.38/ReadBoards.php',
    urlViewSupProfile= 'http://10.100.15.38/viewSupProfile.php',
    url9ViewSupStaffNo = 'http://10.100.15.38/viewSupStaffNo.php',
    urlGetDegreeTypes='http://10.100.15.38/getDegreeTypes.php'})
  async {

    bool proceed=false;

  print("EMAIL: "+email+", Password: "+Password);

    final response = await client.post(
        urlLogin,
        body: {
          'Email': email.toLowerCase(),
          'Password': Password
        });
//    print((response.body));
    //var datauser = json.decode(response.body);
    if(response!=null){
      String msg="";
      if (json.decode(response.body)== "No user found." || json.decode(response.body)=="Invalid password.") {
        proceed=false;
        msg = "Incorrect email or password!";
      }
      else {
        msg="Found user, assigning attributes ...";
        List datauser=json.decode(response.body);

        user.email = datauser[0]['Email'];
        user.userTypeID = int.parse(datauser[0]['UserTypeId']);
        // return true;


        TaskStatusController taskStatusController=new TaskStatusController();
        AssignmentTypeController assignmentTypeController=new AssignmentTypeController();

        await taskStatusController.getStatuses(client,url: urlGetTaskStatus);
        await assignmentTypeController.getTypes(client,url: urlGetAssignmentTypes);
        await studentTypeController.getTypes(client,url: urlGetStudTypes);
        await degreeController.getDegrees(client,url: urlGetDegreeTypes);


        if (user.userTypeID==1){

          await studentController.setStudentUser(user.email,client,urlViewStudentProfile: urlViewStudentProfile,urlReadBoards:urlReadBoards,
              urlViewStudentStudNo:urlViewStudentStudNo );

        }
        else{
          //NB STILL NEED TO TEST FOR SUPERVISOR!
          await supervisorController.setUserSup(email, urlViewSupProfile: urlViewSupProfile,
              urlReadBoards: urlReadBoards);

        }
        proceed=true;
      }
      print(msg);
    }

    return proceed;
  }

  /*
  The following method is used to return all instances in the User table in the
  database as a list of User objects.
   */
  // ignore: non_constant_identifier_names
  Future<List<User>> ReadUsers({url='http://10.100.15.38/readUsers.php'}) async {
    List<User> registered=[];
    String msg='';
//    // SERVER API URL
//    var url =
//    'http://10.100.15.38/readUsers.php';
////        'https://witsinnovativeskyline.000webhostapp.com/readUsers.php';




    // Starting Web API Call.
    var response = await http.post(url);

    // Getting Server response into variable.
    // ignore: non_constant_identifier_names
    var Response = jsonDecode(response.body);
    print(Response);


    if (Response.length == 0) {

      msg="No registered users.";
    }
    else {
      msg='Registered users found.';
      registered=[];
      for (int i = 0; i < Response.length; i++) {

        User userReceived = new User();
        userReceived.userID = int.parse(Response[i]['UserID']);
        userReceived.email = Response[i]['Email'];
        userReceived.userTypeID=int.parse(Response[i]['UserTypeId']);
        registered.add(userReceived);
      }



    }
    print(msg);
    return registered;
  }

  /*
  This method exists for the main reason that when a user would like to share a
  board, we have a means of checking that the board is being shared with a valid
  user.
   */
  // ignore: non_constant_identifier_names
  Future<bool> userExists(String Email,{url="http://10.100.15.38/readUsers.php",}) async{
    print("Looking for: "+Email);
    List<User> registeredUsers=await ReadUsers(url:url);
    bool exists=false;
    for (int i=0;i<registeredUsers.length;i++){
      if(registeredUsers[i].email.toLowerCase()==Email.toLowerCase()){
        print("FOUND USER");
        exists=true;
      }
    }
    return exists;
  }

  /*
  This method is used to retrieve the user details/attributes based on the given
  email address.
   */
  // ignore: non_constant_identifier_names
  Future<User> getUser(String Email,{url="http://10.100.15.38/readUsers.php"}) async{
    List<User> registeredUsers=await ReadUsers(url:url);
    User giveUser=new User();
    for (int i=0;i<registeredUsers.length;i++){
      if(registeredUsers[i].email.toLowerCase()==Email.toLowerCase()){
        giveUser=registeredUsers[i];
      }
    }
    return giveUser;
  }

  /*
  This method serves the purpose of resetting a users password. This is done by
  passing in an email address and password so that the instance associated with
  the user/email may be retrieved and subsequently updated with the given
  password(hashing is done within the PHP script).
   */
  // ignore: non_constant_identifier_names
  String ResetString="";
  // ignore: non_constant_identifier_names
  Future<String> ResetPassword(String email, String password,http.Client client,{url='http://10.100.15.38/ResetPassword.php'}) async{

    var data =
    {
      'Email': email.toLowerCase(),
      'Password': password
    };

    /*The script below should take in the email and check if there exists a user
    * associated with the given email address. */
    final response = await client.post(
        url,
        body: json.encode(data) );


    var result = json.decode(response.body);

    print(result);

    if (result=="No user found.") {

        ResetString = "No user found :(";

    } else if (result=="Password updated successfully") {

      ResetString="Successfully updated password!";

    }
    print(ResetString);
    return ResetString;

  }

}
