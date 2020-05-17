import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgrad_tracker/View/register/StudentRegister.dart';


Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle, child: widget),
  );
}

// ignore: non_constant_identifier_names
Finder widgetWithText(Type TextFormField, String text, { bool skipOffstage = true}){
  return find.ancestor(
    of: find.text(text,skipOffstage: skipOffstage),
    matching: find.byType(TextFormField, skipOffstage: skipOffstage),
  );
}

new Button(
child: new Text('Student Number')
)

void main(){
  final Student = new StudentRegisterPage();



  tester.tap(find.widgetWithText(Button, 'Student Number'));




//  testWidgets('must work', (WidgetTester tester) async {
//    await tester.pumpWidget(find.byType(Type TextFormField()));
//  });

}
