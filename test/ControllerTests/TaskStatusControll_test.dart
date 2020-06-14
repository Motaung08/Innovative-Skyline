import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

class MockTaskStatusController extends TaskStatusController implements Mock{}

void main(){
  test('Test TaskStatusController', () async {

    TaskStatusController client = TaskStatusController();
    http.Client httpClient=new http.Client();
    await client.getStatuses(httpClient,url: 'https://lamp.ms.wits.ac.za/~s1611821/getTaskStatuses.php');

    expect(taskStatuses.length, greaterThan(0));

  });
}