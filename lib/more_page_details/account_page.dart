import 'package:flutter/material.dart';

import '../widgets/more_list_titles/description_list_title.dart';

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
  Widget _buildBody() {
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
            _buildCard(widget.information['firstName'], 'First Name'),
            _buildCard(widget.information['lastName'], 'Last Name'),
            _buildCard(widget.information['nickName'], 'NickName'),
            _buildCard(widget.information['email'], 'E-Mail'),
            _buildCard(widget.information['number'], 'Phone Number'),
          ],
        ),
      ),
    );
  }

  

  Widget _buildCard(String title, String description) {
    return DescriptionListTitle(title, description);
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
