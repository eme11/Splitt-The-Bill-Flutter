import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';
import '../models/user.dart';
import '../models/cleaning_suppliy.dart';

import '../widgets/more_list_titles/user_split_list_title.dart';
import '../widgets/ui_elements/price_tag.dart';

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
      children: _buildList(users, supplies),
    ));
  }

  List<Widget> _buildList(List<User> users, List<CleainingSupply> supplies) {
    List<Widget> _list = [];
    List<_UserIdAndMoney> money = [];
    double totalPrice = 0.0;
    for (int i = 0; i < users.length; ++i) {
      money.add(_UserIdAndMoney(users[i].id, 0));
    }

    for (int i = 0; i < supplies.length; ++i) {
      _UserIdAndMoney tmp = money.firstWhere((_UserIdAndMoney money) {
        return money.id == supplies[i].userId;
      });
      int index = money.indexOf(tmp);
      tmp.money += supplies[i].price;
      money.removeAt(index);
      money.add(tmp);
      totalPrice += supplies[i].price;
    }

    for(int i = 0; i < money.length; ++i){
      if(money[i].id == users[i].id) {
        double percantage = money[i].money  / totalPrice;
        _list.add(UserSplitListTitle(users[i], percantage, money[i].money));
      }
    }

    _list.add(Divider());

    Widget total = ListTile(
      title: Text("Total : "),
      trailing: PriceTag(totalPrice, horizontal: 3, vertical: 1.75,),
    );
    _list.add(total);

    return _list;
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
            child: Text('RESET'),
          )
        ],
      );
    });
  }
}

class _UserIdAndMoney {
  String id;
  double money;

  _UserIdAndMoney(this.id, this.money);
}
