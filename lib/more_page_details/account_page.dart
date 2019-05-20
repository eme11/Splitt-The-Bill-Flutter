import 'package:flutter/material.dart';

import '../widgets/more_list_titles/simple_list_title.dart';

class AccountInformation extends StatefulWidget {
  Map<String, dynamic> information = {
    'lastName': 'Mathe',
    'firstName': 'Emese',
    'Phone number': '0740797202',
    'email': 'emese.mathe.07@gmail.com'
  };

  @override
  State<StatefulWidget> createState() {
    return _AccountInfromationState();
  }
}

class _AccountInfromationState extends State<AccountInformation> {


  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: CircleAvatar(child: Text('EM')),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    /*Widget billBoardCards;
    if (widget.information.length > 0) {
      billBoardCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return SimpleListTitle()
        },
        itemCount: widget._billBoardCards.length,
      );
    } else
      billBoardCards = Container();
    return billBoardCards;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Account Information'),
      ),
      body: _buildBody(),
    );
  }
}
