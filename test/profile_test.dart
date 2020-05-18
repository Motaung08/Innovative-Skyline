import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/Model/User.dart';
import 'package:postgrad_tracker/View/profile/student/ViewStudentProfile.dart';
import 'package:postgrad_tracker/main.dart';



Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}


void main(){
  group('User',()
  {
    final User user = new User();

    testWidgets('Find the studentProfile', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(MyApp()));
//
//      final studentProfile =find.byKey(Key('StudentProfile'));
//      expect(studentProfile, findsOneWidget);
    });

    test("getter and setter methods", () {
      student.fName = "Tshepang";
      expect(student.fName, "Tshepang");
    });


    testWidgets('All pages should be accessed!!!', (WidgetTester tester) async {
      final childWidget = Padding(padding: EdgeInsets.zero);

      await tester.pumpWidget(Container(child: childWidget));
    });


  });



}