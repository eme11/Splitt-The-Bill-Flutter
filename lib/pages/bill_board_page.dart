import 'package:flutter/material.dart';
import '../pop_up_widows/bill_board_announcement.dart';
import '../widgets/ui_elements/bill_board_card.dart';

class BillBoardPage extends StatefulWidget {
  List<Widget> _billBoardCards = [];

  @override
  State<StatefulWidget> createState() {
    return _BillBoardPageState();
  }
}

class _BillBoardPageState extends State<BillBoardPage>{

  void addToBillBoard(Map<String, dynamic> value) {
    if (value != null) {
      setState(() {
        widget._billBoardCards.add(BillBoardCard(value));
      });
    }
  }

  Widget _buildBody() {
    Widget billBoardCards;
    if (widget._billBoardCards.length > 0) {
      billBoardCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[widget._billBoardCards[index]],
          );
        },
        itemCount: widget._billBoardCards.length,
      );
    } else
      billBoardCards = Container();
    return billBoardCards;
  }

  Widget blahblah() {
    Map<String, dynamic> _formData = {
      'title': 'NNNNNNN',
      'type': true,
      'description': 'LLLLLLLLLLLLLLLLLL',
      'expiration': 24,
      'user':'anonymous_user'
    };
    setState(() {
      widget._billBoardCards.add(BillBoardCard(_formData));
    });

    Widget billBoardCards;
    if (widget._billBoardCards.length > 0) {
      billBoardCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[widget._billBoardCards[index]],
          );
        },
        itemCount: widget._billBoardCards.length,
      );
    } else
      billBoardCards = Container();
    return billBoardCards;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: blahblah(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => BillBoardForm(addToBillBoard));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
