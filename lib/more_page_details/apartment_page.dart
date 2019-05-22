import 'package:flutter/material.dart';
import '../pop_up_widows/apparment_create.dart';
import '../widgets/more_list_titles/title_list_title.dart';
import '../widgets/cards/user_information_card.dart';
import '../pop_up_widows/add_user_form.dart';
import '../pop_up_widows/delete_warning.dart';

import '../models/apartment.dart';
import '../models/user.dart';

// ignore: must_be_immutable
class ApartmentPage extends StatefulWidget {
  bool _isDeleted = false;
  List<User> userList = [
    User('ss', 'Emese', 'Mathe', 'Eme', '0740797202', 'emese.@gmail.com')
  ];
  Apartment address = new Apartment('1', 'Blah', 0, 'Timisoara', 'RO');

  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }
}

class _ApartmentPageState extends State<ApartmentPage> {
  List<Widget> info = [];

  initState() {
    info.add(_buildIcon());
    info.add(_buildSizedBox());
    info.add(_buildAddress());
    info.add(_buildSizedBox());
    _buildUserLis();
    super.initState();
  }

  Widget _buildIcon() {
    return CircleAvatar(
      child: Icon(Icons.home),
      maxRadius: 25,
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  void _buildUserLis() {
    for (var i = 0; i < widget.userList.length; ++i) {
      UserInfoCard card = UserInfoCard(
        widget.userList[i],
        delete: _deleteUser,
      );
      info.add(card);
    }
  }

  Widget _buildAddress() {
    return TitleListTitle(
        widget.address,
        Icons.business,
        ApartmentCreate(widget.address,_deleteFalse, _addAddress, _addUser,
            title: 'Edit Address'));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(children: <Widget>[info[index]]);
          },
          itemCount: info.length,
        ),
      ),
    );
  }

  bool _deleteTrue() {
    setState(() {
      widget._isDeleted = true;
    });
    return true;
  }

  bool _deleteFalse() {
    setState(() {
      widget._isDeleted = false;
    });
    return false;
  }

  void _addUser(User user) {
    setState(() {
      widget.userList.add(user);
      info.add(UserInfoCard(user));
    });
  }

  void _deleteUser(User user, {UserInfoCard card}) {
    setState(() {
      widget.userList.remove(user);
      info.remove(card);
    });
  }

  void _addAddress(Apartment apartment) {
    setState(() {
      widget.address = Apartment.clone(apartment);
      info.removeAt(2);
      info.insert(2, _buildAddress());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Apartment'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      DeleteWarningMessage(_deleteTrue));
            },
          )
        ],
      ),
      body: widget._isDeleted ? Container() : _buildBody(context),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ApartmentCreate(widget.address, _deleteFalse, _addAddress, _addUser));
          },
          child: Icon(Icons.add),
          mini: true,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AddUserForm(_addUser));
          },
          child: Icon(Icons.account_circle),
          mini: true,
        ),
      ]),
    );
  }
}
