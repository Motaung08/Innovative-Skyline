import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Model/TaskStatus.dart';


void main(){
  test('Test TaskStatusController', (){
    TaskStatus testStatus = new TaskStatus();

    testStatus.TaskStatusID = 1;
    expect(testStatus.TaskStatusID, 1);

    testStatus.Status = 'Assigned';
    expect(testStatus.Status, 'Assigned');
  });
}