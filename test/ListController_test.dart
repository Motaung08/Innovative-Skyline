import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/ListController.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';



class Post {
  dynamic data;
  Post.fromJson(this.data);
}

//switch

Widget makeWidgetTestable(Widget widget){
  return MaterialApp(
    home: DefaultAssetBundle(bundle: rootBundle,child: widget),
  );
}


// ignore: must_be_immutable
class MockList extends Mock implements ListCard{
  @override
  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    String fullString;
    assert(() {
      fullString = toDiagnosticsNode(style: DiagnosticsTreeStyle.singleLine).toString(minLevel: minLevel);
      return true;
    }());
    return fullString ?? toStringShort();
  }  
}

void main() {
  group('Server connection', () {

    ListController lc=new ListController();
    String message ='';
    test('Create lists',() async{
      message = "No Lists created yet";
      ListController listController=new ListController();
      ListCard mockList=MockList();
      mockList.ProjectID=103;
      mockList.List_Title="Test creation";
      expect(await listController.createList(mockList), message="List created!");

    });

    test('Read lists',() async{
      ListController listController=new ListController();

      expect(await listController.ReadLists(103), isInstanceOf<List<ListCard>>());



    });

    //NOTE: Sometimes fails?
    test('Update lists',() async{
      ListController listController=new ListController();
      ListCard mockList=MockList();
      List<ListCard> testlists=[];
      testlists=await listController.ReadLists(103);
      mockList.ProjectID=103;
      mockList.List_Title="Test creation update";
      mockList.ListID=testlists.last.ListID;

      expect(await listController.updateList(mockList), "List updated successfully");



    });
    test('delete lists',() async{
      ListController listController=new ListController();
      ListCard mockList=MockList();
      List<ListCard> testlists=[];
      testlists=await listController.ReadLists(103);
      int listID=testlists.last.ListID;

      expect(await listController.deleteList(listID), "List DELETED!");



    });

  });

}
