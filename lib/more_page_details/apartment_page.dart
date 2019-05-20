import 'package:flutter/material.dart';
import '../pop_up_widows/apparment_create.dart';
import '../widgets/more_list_titles/title_list_title.dart';

class ApartmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }
}

class _ApartmentPageState extends State<ApartmentPage> {
  Map<String, dynamic> _formData = {
    'address': 'Str. Biruintei nr. 1',
    'userList': [
      {
        'lastName': 'Mathe',
        'firstName': 'Emese',
        'nickName': 'Eme',
        'number': '0740797202',
        'email': 'emese.mathe.07@gmail.com'
      },
      {
        'lastName': 'Mathe',
        'firstName': 'Emese',
        'nickName': 'Eme',
        'number': '0740797202',
        'email': 'emese.mathe.07@gmail.com'
      },
      {
        'lastName': 'Mathe',
        'firstName': 'Emese',
        'nickName': 'Eme',
        'number': '0740797202',
        'email': 'emese.mathe.07@gmail.com'
      }
    ]
  };

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

  Widget _buildUserLis() {}

  Widget _buildAddress() {
    return TitleListTitle(_formData['address'], Icons.business);
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildIcon(),
            _buildSizedBox(),
            _buildAddress(),
            _buildSizedBox(),
            //_buildUserLis(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Apartment'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ApartmentCreate());
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
