import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Model/Task.dart';
import 'package:postgrad_tracker/Model/TaskStatus.dart';


class Post {
  dynamic data;
  Post.fromJson(this.data);
}

class MockClient extends Mock implements http.Client {}

Future<Post> fetchPost(http.Client client) async {
  final response =
  await client.get('https://witsinnovativeskyline.000webhostapp.com/ReadTasks.php');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}



void main() {

    test("TaskStatusController Test", () async {
      TaskController testTask = new TaskController();
      TaskStatus taskStatus = new TaskStatus();

      await testTask.ReadTasks(taskStatus.TaskStatusID=1);

      expect(taskStatus.Status='Assigned','Assigned');

      taskStatus.createState();
//      await testTask.ReadTasks(taskStatus.TaskStatusID=2);
//
//      expect(taskStatus.Status= 'Acknowledged', 'Acknowlegded');

    });





}