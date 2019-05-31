import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pop_up_widows/apparment_create.dart';
import '../widgets/more_list_titles/title_list_title.dart';
import '../widgets/cards/user_information_card.dart';
import '../pop_up_widows/add_user_form.dart';
import '../pop_up_widows/delete_warning.dart';

import '../models/user.dart';
import '../models/apartment.dart';
import '../scoped_models/main_model.dart';

class ApartmentPage extends StatefulWidget {
  bool _isDeleted = false;

  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }
}

class _ApartmentPageState extends State<ApartmentPage> {
  @override
  initState() {
    setState(() {
      widget._isDeleted = false;
    });
    super.initState();
  }

  Widget _buildCard({
    bool isUserCard = true,
    Apartment apartment,
    User user,
    Function delete,
  }) {
    return isUserCard ? _buildUserCard(user, delete) : _buildAddress(apartment);
  }

  Widget _buildUserCard(User user, Function delete) {
    return UserInfoCard(user, delete: delete);
  }

  Widget _buildIcon() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            child: Icon(Icons.home),
            maxRadius: 25,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildAddress(Apartment apartment) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleListTitle(apartment, Icons.business,
              ApartmentCreate(_deleteFalse, title: 'Edit Address')),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildBody(Apartment apartment, List<User> userList, bool isLoading,
      Function delete) {
    Widget info;
    if (!widget._isDeleted && !isLoading) {

      info = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          print('ggggggggggggggg');
          return Column(children: <Widget>[
            index == 0
                ? _buildIcon()
                : index == 1
                    ? _buildCard(isUserCard: false, apartment: apartment)
                    : _buildCard(user: userList[index - 2], delete: delete)
          ]);
        },
        itemCount: userList.length + 2,
      );
    } else if (isLoading) {
      info = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      info = Container();
    }
    return info;
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
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
        body: _buildBody(model.currentApartmnet, model.userList,
            model.isApartmentLoading, model.deleteUser),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      ApartmentCreate(_deleteFalse));
            },
            child: Icon(Icons.add),
            mini: true,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddUserForm(model.addUser));
            },
            child: Icon(Icons.account_circle),
            mini: true,
          ),
        ]),
      );
    });
  }
}
