import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/TaskStatusController.dart';
import 'package:postgrad_tracker/main.dart';

class MockTaskStatusController extends TaskStatusController implements Mock{}

void main(){

//  group('Server connection', () {
    test(
        'Task Status', () async {
      TaskStatusController fetchStatus=new TaskStatusController();

      expect(await fetchStatus.getStatuses(url: "https://lamp.ms.wits.ac.za/~s1611821/getTaskStatuses.php"),isNull);
    });



//  test('Test TaskStatusController', () async {
//
//    final client = MockTaskStatusController();
//    client.toString();
//
//    expect(taskStatuses.length, lessThanOrEqualTo(0));
//
//  });
}