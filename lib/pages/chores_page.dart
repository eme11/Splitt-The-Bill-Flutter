import 'package:flutter/material.dart';

import '../pop_up_widows/chores_form.dart';
import '../widgets/cards/chores_card.dart';

class ChoresPage extends StatefulWidget{
  List<Widget> _choresCards = [];
  @override
  State<StatefulWidget> createState() {
    return _ChoresPageState();
  }

}

class _ChoresPageState extends State<ChoresPage>{

  Widget _buildBody(){
    Widget choresCard;
    if (widget._choresCards.length > 0) {
      choresCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                deleteChoresCard(widget._choresCards[index]);
              } else if (direction == DismissDirection.startToEnd) {
                print('Swiped start to end');
              } else {
                print('Other swiping');
              }
            },
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[widget._choresCards[index]],
            ),
          );
        },
        itemCount: widget._choresCards.length,
      );
    } else
      choresCard = Container();
    return choresCard;
  }

  void addChoresCard(Map<String,dynamic> value){
    setState(() {
      widget._choresCards.add(ChoresCard(value));
    });
  }

  void deleteChoresCard(ChoresCard card){
    setState(() {
      widget._choresCards.remove(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ChoresForm(addChoresCard));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

}