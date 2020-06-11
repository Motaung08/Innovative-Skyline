

import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Controller/AssignmentTypeController.dart';
import 'package:postgrad_tracker/main.dart';

void main() {
  test(
      'populates assignment type array if the http call completes successfully', () async {
    final client = AssignmentTypeController();
    await client.getTypes(url: 'https://lamp.ms.wits.ac.za/~s1611821/getAssignmentTypes.php');

    expect(assignmentTypes.length, greaterThan(0));

  });

}