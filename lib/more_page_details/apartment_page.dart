import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pop_up_widows/apparment_create.dart';
import '../widgets/more_list_titles/title_list_title.dart';
import '../widgets/cards/user_information_card.dart';
import '../pop_up_widows/add_user_form.dart';
import '../pop_up_widows/delete_warning.dart';

import '../models/user.dart';
import '../scoped_models/main_model.dart';

// ignore: must_be_immutable
class ApartmentPage extends StatefulWidget {
  bool _isDeleted = false;
  MainModel model;

  ApartmentPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }
}

class _ApartmentPageState extends State<ApartmentPage> {
  Widget _buildCard(
      {bool isUserCard = true,
        MainModel model,
        User user,
        Function delete,}) {
    return isUserCard
        ? _buildUserCard(user, delete)
        : _buildAddress(model);
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

  Widget _buildAddress(MainModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleListTitle(model.currentApartmnet, Icons.business,
              ApartmentCreate(_deleteFalse, title: 'Edit Address')),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MainModel model) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(children: <Widget>[
          index == 0
              ? _buildIcon()
              : index == 1
              ? _buildCard(isUserCard: false, model: model)
              : _buildCard(
              user: model.userList[index], delete: model.deleteUser)
        ]);
      },
      itemCount: model.userList.length,
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.currentUser != null && model.currentUser.aid != null) {
            model.fetchCurrentApartment();
          }
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
            body: widget._isDeleted ? Container() : _buildBody(context, model),
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
