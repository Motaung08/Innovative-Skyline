import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/View/profile/supervisor/ViewSupProfile.dart';

void main(){
  test('validation failed', (){
    final results = ViewStudentProfilePage.validate(null);
    expect(results, 'null');

  });
  test('validation passed', (){
    final results = ViewStudentProfilePage.validate('nully');
    expect(results, 'nully');

  });
  test('validation date failed', (){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final results = ViewStudentProfilePage.validateDate(null);
    expect(results, dateFormat.parse('0000-00-00'));

  });
  test('validation date passed', (){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final DateTime dateTime =DateTime(2000);
    final results = ViewStudentProfilePage.validateDate(dateTime);
    expect(results, dateTime);

  });
  test('validation1 failed', (){
    final results = ViewSupProfilePage.validate(null);
    expect(results, 'null');

  });
  test('validation1 passed', (){
    final results = ViewSupProfilePage.validate('nully');
    expect(results, 'nully');

  });
}