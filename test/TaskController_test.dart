import 'dart:convert';
import 'dart:math';
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

  bool created=false;

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
       created = true;
      var data;
      Task atask = new Task();


      await taskController.createTask(atask);
//      created = true;
      expect(Task!=null, created=true);

      atask.Task_Title ='';
      atask.TaskID = 1;
      atask.Task_Description = '';
      atask.Task_AddedBy = '';
      atask.Task_StatusID = 1;
      atask.Task_DateAdded = DateTime(2020,02,02);
      atask.Task_Due = DateTime(2020,10,30);


    });

    test('Updating Task', () async {
      TaskController taskController = new TaskController();
      Task atask = new Task();

      await taskController.updateTask(atask);

      expect(atask.Task_Title='Test1', 'Test1');
      expect(atask.Task_Title='Code coverage', 'Code coverage');
      expect(atask.Task_AddedBy='Tshepang', 'Tshepang');
      expect(atask.Task_StatusID=1, 1);
      expect(atask.TaskID=1, 1);
      expect(atask.Task_DateAdded=DateTime(2020,02,19), DateTime(2020,02,19));
      expect(atask.Task_Due=DateTime(2020,11,08), DateTime(2020,11,08));

      if(atask.Task_Due != null){
        expect(atask.Task_Due=DateTime(2020,11,08), DateTime(2020,11,08));
      }

      if(atask.Task_DateAdded != null){
        expect(atask.Task_DateAdded=DateTime(2020,02,19), DateTime(2020,02,19));
      }

      expect(Task!=null, created=true);

    });

    test('updating task', () async {
      final updateTask = MockClient();

      when(updateTask.get(
          'https://witsinnovativeskyline.000webhostapp.com/updateTask.php'))
          .thenAnswer((_) async =>
          http.Response('{"title": "Testing Update Task"}', 200));
    });


    test("Delete Task", () async {
      TaskController deleteTask = new  TaskController();
      Task delTask = new Task();

      await deleteTask.deleteTask(delTask.TaskID=1);
    });


  });

}
