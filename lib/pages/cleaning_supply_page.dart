import 'package:flutter/material.dart';

import '../pop_up_widows/cleaning_supplies_form.dart';
import '../widgets/cards/cleaning_supply_card.dart';

class CleaningSuppliesPage extends StatefulWidget{
  List<Widget> _cleaningSuppliesCard = [];
  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesPageState();
  }

}

class _CleaningSuppliesPageState extends State<CleaningSuppliesPage>{

  Widget _buildBody(){
    Widget cleaningSupplyCard;
    if (widget._cleaningSuppliesCard.length > 0) {
      cleaningSupplyCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                deleteCleaningSupply(widget._cleaningSuppliesCard[index]);
              } else if (direction == DismissDirection.startToEnd) {
                print('Swiped start to end');
              } else {
                print('Other swiping');
              }
            },
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[widget._cleaningSuppliesCard[index]],
            ),
          );
        },
        itemCount: widget._cleaningSuppliesCard.length,
      );
    } else
      cleaningSupplyCard = Container();
    return cleaningSupplyCard;
  }

  void addCleaningSupply(Map<String,dynamic> value){
    if (value != null) {
      setState(() {
        widget._cleaningSuppliesCard.add(CleaningSupplyCard(value));
      });
    }
  }

  void deleteCleaningSupply(CleaningSupplyCard card){
    setState(() {
      widget._cleaningSuppliesCard.remove(card);
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
              builder: (BuildContext context) => CleaningSuppliesForm(addCleaningSupply));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

}