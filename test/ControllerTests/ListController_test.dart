import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:postgrad_tracker/Controller/ListController.dart';
import 'package:postgrad_tracker/Model/ListCard.dart';
import 'package:http/http.dart' as http;
http.Client client = new http.Client();

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

class MockListController extends Mock implements ListController{}


void main() {
  group('Test CRUD List', () {

    test('Create lists',() async{

      ListController listController=new ListController();
      ListCard egList=new ListCard();
      egList.ProjectID=103;
      egList.List_Title="Test creation";
      expect(await listController.createList(egList,url: "https://lamp.ms.wits.ac.za/~s1611821/createList.php"),"List created!");

    });

    test('Read lists',() async{
      ListController listController=new ListController();

      expect(await listController.ReadLists(103,client,url: "https://lamp.ms.wits.ac.za/~s1611821/ReadLists.php", url2: "https://lamp.ms.wits.ac.za/~s1611821/ReadTasks.php"), isInstanceOf<List<ListCard>>());

    });

    //NOTE: Sometimes fails?
    test('Update lists',() async{
      ListController listController=new ListController();
      ListCard mockList=ListCard();
      List<ListCard> testlists=[];
      testlists=await listController.ReadLists(103,client,url: "https://lamp.ms.wits.ac.za/~s1611821/ReadLists.php", url2: "https://lamp.ms.wits.ac.za/~s1611821/ReadTasks.php");
      mockList=testlists.last;
      //mockList.ProjectID=103;
      mockList.List_Title="Test creation update";
      //mockList.ListID=testlists.last.ListID;

      expect(await listController.updateList(mockList,url: "https://lamp.ms.wits.ac.za/~s1611821/updateList.php"), "List updated successfully");



    });
    test('delete lists',() async{
      ListController listController=new ListController();
      List<ListCard> testlists=[];
      testlists=await listController.ReadLists(103,client, url: "https://lamp.ms.wits.ac.za/~s1611821/ReadLists.php", url2: "https://lamp.ms.wits.ac.za/~s1611821/ReadTasks.php");
      int listID=testlists.last.ListID;

      expect(await listController.deleteList(listID,url: "https://lamp.ms.wits.ac.za/~s1611821/deleteList.php"), "List DELETED!");



    });

  });

}