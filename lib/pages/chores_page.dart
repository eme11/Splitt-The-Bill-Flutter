import 'package:flutter/material.dart';
import '../pop_up_widows/bill_board_announcement.dart';

class ChoresPage extends StatelessWidget {
  List<Map<String, dynamic>> _announcements = [];

  void _addToBillBoard(Map<String,dynamic> value){
    if(value != null)
      _announcements.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => BillBoardForm(_addToBillBoard));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
