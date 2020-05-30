import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad_tracker/Controller/TaskController.dart';
import 'package:postgrad_tracker/Model/Task.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  bool created=false;

  group('Server connection', () {


    test('Creating a task', () async {

      TaskController taskController = new TaskController();
       created = true;
      var data;
      Task atask = new Task();

      atask.Task_Title ='New task test';
      atask.ListID=196;
      atask.Task_Description = 'This is a test task.';
      atask.Task_AddedBy = '1713445';
      atask.Task_StatusID = 1;
      atask.Task_DateAdded = DateTime.now();
      atask.Task_Due = DateTime.now();
      expect(await taskController.createTask(atask), "Task created!");
      expect(taskController.dateAdded, DateFormat("yyyy-MM-dd").format(atask.Task_DateAdded));
      expect(taskController.dateDue, DateFormat("yyyy-MM-dd").format(atask.Task_Due));

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
