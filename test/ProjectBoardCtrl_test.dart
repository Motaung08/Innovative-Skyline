import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postgrad_tracker/Controller/Project_BoardController.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}



void main() {
  group('All Models should be accessed', () {
    testWidgets('Test Listcard', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(Project_BoardController()));
    });
  });
}