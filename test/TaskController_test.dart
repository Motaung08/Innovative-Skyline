import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Model/Task.dart';

import 'Models_test.dart';


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
  group('Server connection', () {
    test(
        'returns a Post if the TaskController http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'https://witsinnovativeskyline.000webhostapp.com/ReadTasks.php'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
    });

    test(
        'returns a Post if the TaskController http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'https://witsinnovativeskyline.000webhostapp.com/ReadTasks.php'))
          .thenAnswer((_) async =>
          http.Response('{"title: TaskController"}', 200));
    });

    test(
        'returns a Post if the TaskController http call completes successfully', () async {
      final client = MockClient();

      when(client.get(
          'https://witsinnovativeskyline.000webhostapp.com/ReadTasks.php'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });

    test('Creating a task', () async {
      TaskController taskController = new TaskController();
      bool created = true;
      var data;
      Task atask = new Task();


      await taskController.createTask(atask);
      expect(Task!=null, true);

      atask.Task_Title ='';
      atask.TaskID = 1;
      atask.Task_Description = '';
      atask.Task_AddedBy = '';
      atask.Task_StatusID = 1;
      atask.Task_DateAdded = DateTime(2020,02,02);
      atask.Task_Due = DateTime(2020,10,30);




    });


  });

}
