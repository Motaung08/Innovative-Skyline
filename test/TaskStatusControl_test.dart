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
  bool created = false;

  group('Server connection', () {
    test(
        'returns a Post if the TaskStatusController http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'ttps://witsinnovativeskyline.000webhostapp.com/getTaskStatuses.php'))
          .thenAnswer((_) async => http.Response('{"title": "Test TaskStatusController"}', 200));
    });

    test(
        'returns a Post if the TaskStatusController http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'ttps://witsinnovativeskyline.000webhostapp.com/getTaskStatuses.php'))
          .thenAnswer((_) async =>
          http.Response('{"title: TaskStatusController"}', 200));
    });


    test("TaskStatusController Test", () async {
      TaskController testTask = new TaskController();
      TaskStatus taskStatus = new TaskStatus();
      int n = 5;
      // ignore: unnecessary_statements

      taskStatus.TaskStatusID = 1;
      expect(taskStatus.TaskStatusID, 1);
      taskStatus.Status = 'Assigned';

      taskStatus.createState();
      taskStatus.TaskStatusID =2;
      expect(taskStatus.TaskStatusID, 2);
      taskStatus.Status = 'Acknowledge';

      taskStatus.createState();
      taskStatus.TaskStatusID=3;
      expect(taskStatus.TaskStatusID, 3);
      taskStatus.Status = 'Pending';

      taskStatus.createState();
      taskStatus.TaskStatusID=4;
      expect(taskStatus.TaskStatusID, 4);
      taskStatus.Status = 'Complete';


    });


  });


}