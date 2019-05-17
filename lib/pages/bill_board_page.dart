import 'package:flutter/material.dart';
import '../pop_up_widows/bill_board_announcement.dart';
import '../widgets/cards/bill_board_card.dart';

class BillBoardPage extends StatefulWidget {
  List<Widget> _billBoardCards = [];

  @override
  State<StatefulWidget> createState() {
    return _BillBoardPageState();
  }
}

class _BillBoardPageState extends State<BillBoardPage> {
  void addToBillBoard(Map<String, dynamic> value) {
    if (value != null) {
      setState(() {
        widget._billBoardCards.add(BillBoardCard(value));
      });
    }
  }

  void deleteFromBillBoard(BillBoardCard value) {
    setState(() {
      widget._billBoardCards.remove(value);
    });
  }

  Widget _buildBody() {
    Widget billBoardCards;
    if (widget._billBoardCards.length > 0) {
      billBoardCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                deleteFromBillBoard(widget._billBoardCards[index]);
              } else if (direction == DismissDirection.startToEnd) {
                print('Swiped start to end');
              } else {
                print('Other swiping');
              }
            },
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[widget._billBoardCards[index]],
            ),
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
      body: _buildBody(),
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
