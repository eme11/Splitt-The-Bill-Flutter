import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/more_list_titles/description_list_title.dart';
import '../pop_up_widows/account_inforamtion_edit.dart';

import '../models/user.dart';
import '../scoped_models/main_model.dart';

class AccountInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountInfromationState();
  }
}

class _AccountInfromationState extends State<AccountInformation> {
  void openPopUp(AccountInformationEditWindow popUp) {
    showDialog(context: context, builder: (BuildContext context) => popUp);
  }

  String _getInitials(String first, String last) {
    return first[0].toUpperCase() + last[0].toUpperCase();
  }

  Widget _buildBody(MainModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(_getInitials(
                  model.currentUser.firstName, model.currentUser.lastName)),
              maxRadius: 25,
            ),
            SizedBox(
              height: 10,
            ),
            _buildCard(
              model.currentUser.firstName,
              'First Name',
              openWindow: openPopUp,
              key: model.updateFirstName,
            ),
            _buildCard(model.currentUser.lastName, 'Last Name',
                openWindow: openPopUp, key: model.updateLastName),
            _buildCard(model.currentUser.nickName, 'NickName',
                openWindow: openPopUp, key: model.updateNickName),
            _buildCard(model.currentUser.email, 'E-Mail', editable: false),
            _buildCard(model.currentUser.phone, 'Phone Number',
                openWindow: openPopUp, key: model.updateNumber, isNumber: true),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description,
      {bool editable = true,
      Function openWindow,
      Function key,
      isNumber = false}) {
    return (editable == false)
        ? _buildWithoutEdit(title, description)
        : _buildWithEdit(title, description, openWindow, key, isNumber);
  }

  Widget _buildWithoutEdit(String title, String description) {
    return DescriptionListTitle(title, description, isEditable: false);
  }

  Widget _buildWithEdit(String title, String description, Function openWindow,
      Function key, isNumber) {
    AccountInformationEditWindow popUp = AccountInformationEditWindow(
      description,
      key,
      isNumber: isNumber,
      value: title,
    );
    return DescriptionListTitle(title, description,
        openWindow: openWindow, popUp: popUp);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Account Information'),
        ),
        body: _buildBody(model),
      );
    });
  }
}
