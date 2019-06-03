import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
            "Bachelor Degree Project",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildSizedBox(),
          _buildSizedBox(),
          _buildSizedBox(),
          Text("Student"),
          Text(
            "Emese MATHE",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildSizedBox(),
          Text('Supervisor'),
          Text(
            "Lect. dr. ing. Oana Iulia Casandra HOLOTESCU",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildSizedBox(),
          _buildSizedBox(),
          _buildSizedBox(),
          _buildSizedBox(),
          Image.asset('assets/virtual7.png'),
          _buildSizedBox(),
          _buildSizedBox(),
          Text('Company logo')
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
