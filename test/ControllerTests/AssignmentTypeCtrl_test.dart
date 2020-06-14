

import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/AssignmentTypeController.dart';
import 'package:postgrad_tracker/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test(
      'populates assignment type array if the http call completes successfully', () async {
    final client = AssignmentTypeController();
    http.Client httpClient=new http.Client();
    await client.getTypes(httpClient,url: 'https://lamp.ms.wits.ac.za/~s1611821/getAssignmentTypes.php');

    expect(assignmentTypes.length, greaterThan(0));

  });

}