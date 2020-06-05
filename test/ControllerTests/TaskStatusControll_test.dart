import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/main.dart';

class MockTaskStatusController extends TaskStatusController implements Mock{}

void main(){
  test('Test TaskStatusController', () async {

    final client = MockTaskStatusController();
    client.toString();

    expect(taskStatuses.length, lessThanOrEqualTo(0));

  });
}