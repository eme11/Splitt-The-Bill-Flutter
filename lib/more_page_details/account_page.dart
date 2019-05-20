import 'package:flutter/material.dart';

import '../widgets/more_list_titles/description_list_title.dart';
import '../pop_up_widows/account_inforamtion_edit.dart';

class AccountInformation extends StatefulWidget {
  Map<String, dynamic> information = {
    'lastName': 'Mathe',
    'firstName': 'Emese',
    'nickName': 'Eme',
    'number': '0740797202',
    'email': 'emese.mathe.07@gmail.com'
  };

  @override
  State<StatefulWidget> createState() {
    return _AccountInfromationState();
  }
}

class _AccountInfromationState extends State<AccountInformation> {
  void upDateField(String key, String value) {
    setState(() {
      widget.information[key] = value;
    });
  }

  void openPopUp(AccountInformationEditWindow popUp) {
    showDialog(context: context, builder: (BuildContext context) => popUp);
  }

  Widget _buildBody() {
    AccountInformationEditWindow popUp =
        AccountInformationEditWindow(upDateField, 'firstName');
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
            _buildCard(widget.information['firstName'], 'First Name',
                openWindow: openPopUp, popUp: popUp),
            _buildCard(widget.information['lastName'], 'Last Name'),
            _buildCard(widget.information['nickName'], 'NickName'),
            _buildCard(widget.information['email'], 'E-Mail', editable: false),
            _buildCard(widget.information['number'], 'Phone Number'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description,
      {bool editable = true,
      Function openWindow,
      AccountInformationEditWindow popUp}) {
    return DescriptionListTitle(title, description,
        isEditable: editable, openWindow: openWindow, popUp: popUp);
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
