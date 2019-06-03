import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';
import '../models/user.dart';
import '../models/cleaning_suppliy.dart';

import '../widgets/more_list_titles/user_split_list_title.dart';

class MoneySplitPopUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoneySplittPopUpState();
  }
}

class _MoneySplittPopUpState extends State<MoneySplitPopUp> {
  Widget _buildBody(List<User> users, List<CleainingSupply> supplies) {
    return SingleChildScrollView(
        child: Column(
      children: _buildList(users),
    ));
  }

  List<Widget> _buildList(List<User> users) {
    List<Widget> _list = [];
    for (int i = 0; i < users.length; ++i) {
      _list.add(UserSplitListTitle(users[i], 0.3));
    }
    _list.add(Divider());
    
    Widget total = _buildTotal();
    _list.add(total);

    return _list;
  }

  Widget _buildTotal(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text('Money Split'),
        content: _buildBody(model.userList, model.supplies),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OKAY'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('SPLIT'),
          )
        ],
      );
    });
  }
}
