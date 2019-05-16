import 'package:flutter/material.dart';
import '../pop_up_widows/bill_board_announcement.dart';

class ChoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => BillBoardForm());
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
