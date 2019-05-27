import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pop_up_widows/chores_form.dart';
import '../widgets/cards/chores_card.dart';

import '../scoped_models/main_model.dart';
import '../models/chores.dart';

class ChoresPage extends StatefulWidget {
  MainModel model;

  ChoresPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ChoresPageState();
  }
}

class _ChoresPageState extends State<ChoresPage> {
  @override
  initState() {
    widget.model.fetchChoreList();
    super.initState();
  }

  Widget _buildBody(List<Chore> list, Function delete, bool isLoading) {
    Widget choresCard;
    if (list.length > 0 && !isLoading) {
      choresCard = ListView.builder(
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
              children: <Widget>[ChoresCard(list[index])],
            ),
          );
        },
        itemCount: list.length,
      );
    } else if (isLoading) {
      choresCard = Center(
        child: CircularProgressIndicator(),
      );
    } else
      choresCard = Container();
    return choresCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        return _buildBody(
            model.chores, model.deleteChoreAt, model.isChoreLoading);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  ChoresForm(widget.model.addChore));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
