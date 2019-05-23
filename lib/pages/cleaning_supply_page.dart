import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pop_up_widows/cleaning_supplies_form.dart';
import '../widgets/cards/cleaning_supply_card.dart';
import '../models/cleaning_suppliy.dart';
import '../scoped_models/main_model.dart';

class CleaningSuppliesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesPageState();
  }

}

class _CleaningSuppliesPageState extends State<CleaningSuppliesPage>{

  Widget _buildBody(List<CleainingSupply> supplies, Function delete){
    Widget cleaningSupplyCard;
    if (supplies.length > 0) {
      cleaningSupplyCard = ListView.builder(
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
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[CleaningSupplyCard(supplies[index])],
            ),
          );
        },
        itemCount: supplies.length,
      );
    } else
      cleaningSupplyCard = Container();
    return cleaningSupplyCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model)
    {
      return Scaffold(
        body: _buildBody(model.supplies, model.deleteSupplyAt),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CleaningSuppliesForm(model.addSupply));
          },
          child: Icon(Icons.add),
          mini: true,
        ),
      );
    });


  }



}