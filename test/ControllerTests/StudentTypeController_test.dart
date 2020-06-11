import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/StudentTypeController.dart';
import 'package:postgrad_tracker/main.dart';




class MockStudentTypeController extends StudentTypeController implements Mock{}
void main() {
//  test(
//      'populates degree array if the http call completes successfully', () async {
//    final client = MockStudentTypeController();
//    await client.getTypes();
//
//    expect(studentTypes.length, greaterThan(0));
//
//  });


  test(
      'Student Type Controller Test', () async {
    StudentTypeController studentTypeController=new StudentTypeController();
    await studentTypeController.getTypes(url: "https://lamp.ms.wits.ac.za/~s1611821/getStudentTypes.php");
    expect(studentTypes.length, greaterThan(0));
  });


}