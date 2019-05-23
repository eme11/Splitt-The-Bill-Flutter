import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/more_list_titles/description_list_title.dart';
import '../pop_up_widows/account_inforamtion_edit.dart';

import '../models/user.dart';
import '../scoped_models/main_model.dart';

class AccountInformation extends StatefulWidget {
  User information =
  User('4', 'Emese', 'Mathe', 'Eme', 'emese@gmaill.com', '0740797202');

  @override
  State<StatefulWidget> createState() {
    return _AccountInfromationState();
  }
}

class _AccountInfromationState extends State<AccountInformation> {
  void upDateField(Function update, String value) {
    update(value);
  }

  void openPopUp(AccountInformationEditWindow popUp) {
    showDialog(context: context, builder: (BuildContext context) => popUp);
  }

  Widget _buildBody(MainModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('EM'),
              maxRadius: 25,
            ),
            SizedBox(
              height: 10,
            ),
            _buildCard(
              widget.information.firstName,
              'First Name',
              openWindow: openPopUp,
              key: 'firstName',
            ),
            _buildCard(widget.information.lastName, 'Last Name',
                openWindow: openPopUp, key: 'lastName'),
            _buildCard(widget.information.nickName, 'NickName',
                openWindow: openPopUp, key: 'nickName'),
            _buildCard(widget.information.email, 'E-Mail', editable: false),
            _buildCard(widget.information.phone, 'Phone Number',
                openWindow: openPopUp, key: 'number', isNumber: true),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description,
      {bool editable = true,
        Function openWindow,
        String key = '',
        isNumber = false}) {
    return (editable == false)
        ? _buildWithoutEdit(title, description)
        : _buildWithEdit(title, description, openWindow, key, isNumber);
  }

  Widget _buildWithoutEdit(String title, String description) {
    return DescriptionListTitle(title, description, isEditable: false);
  }

  Widget _buildWithEdit(String title, String description, Function openWindow,
      String key, isNumber) {
    AccountInformationEditWindow popUp = AccountInformationEditWindow(
      description,
      upDateField,
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
