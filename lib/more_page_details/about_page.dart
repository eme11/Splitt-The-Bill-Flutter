import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  Widget _buildSizedBox(){
    return SizedBox(height: 10.0,);
  }
  Widget _buildBody() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Bachelor Degree Project"),
              _buildSizedBox(),
              Text("Student: Mathe Emese"),
              _buildSizedBox(),
              Text("Professor: Dr. Ing. Casandra Holotescu" ),
              _buildSizedBox(),
              _buildSizedBox(),
              Text('Company log'),
              _buildSizedBox(),
              Image.asset('assets/virtual7.png')
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('About'),
      ),
      body: _buildBody(),
    );
  }
}
