import 'package:flutter/material.dart';
import '../pop_up_widows/apparment_create.dart';
import '../widgets/more_list_titles/title_list_title.dart';
import '../widgets/cards/user_information_card.dart';

class ApartmentPage extends StatefulWidget {
  List<Map<String, dynamic>> userList = [
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
  ];
  String address = 'Str. Biruintei nr. 1';

  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }
}

class _ApartmentPageState extends State<ApartmentPage> {
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

  List<Widget> _buildUserLis() {
    List<Widget> info = [];

    info.add(_buildIcon());
    info.add(_buildSizedBox());
    info.add(_buildAddress());
    info.add(_buildSizedBox());
    for (var i = 0; i < widget.userList.length; ++i) {
      info.add(UserInfoCard(widget.userList[i]));
    }

    return info;
  }

  Widget _buildAddress() {
    return TitleListTitle(widget.address, Icons.business);
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildUserLis(),
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
