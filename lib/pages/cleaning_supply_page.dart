import 'package:flutter/material.dart';

import '../pop_up_widows/cleaning_supplies_form.dart';
import '../widgets/cards/cleaning_supply_card.dart';

class CleaningSuppliesPage extends StatefulWidget{
  List<Map<String,dynamic>> _cleaningSuppliesCard = [];
  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesPageState();
  }

}

class _CleaningSuppliesPageState extends State<CleaningSuppliesPage>{

  Widget _buildBody(){
    return Container();
  }

  void addCleaningSupply(Map<String,dynamic> value){
    if (value != null) {
      setState(() {
        widget._cleaningSuppliesCard.add(value);
      });
    }
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