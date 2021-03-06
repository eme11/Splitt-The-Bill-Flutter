import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pop_up_widows/bill_board_announcement.dart';
import '../widgets/cards/bill_board_card.dart';
import '../models/bill_board.dart';

import '../scoped_models/main_model.dart';

class BillBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BillBoardPageState();
  }
}

class _BillBoardPageState extends State<BillBoardPage> {
  Widget _buildBody(List<BillBoard> list, Function delete, bool isLoading) {
    Widget billBoardCards;
    if (list.length > 0 && !isLoading) {
      billBoardCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                delete(index);
              } else if (direction == DismissDirection.startToEnd) {
                print('Swiped start to end');
              } else {
                print('Other swiping');
              }
            },
            background: Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment(0.85, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Column(
              children: <Widget>[BillBoardCard(list[index], index)],
            ),
          );
        },
        itemCount: list.length,
      );
    } else if (isLoading) {
      billBoardCards = Center(
        child: CircularProgressIndicator(),
      );
    } else
      billBoardCards = Container();
    return billBoardCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Split the bill'),
          automaticallyImplyLeading: false,
        ),
        body: _buildBody(model.announcement, model.deleteAnnouncementAt,
            model.isBillBoardLoading),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    BillBoardForm(model.addAnnouncements));
          },
          child: Icon(Icons.add),
          mini: true,
        ),
      );
    });
  }
}
