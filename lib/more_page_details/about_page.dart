import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  Widget _buildBody() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Bachelor Degree Project"),
              Text("Mathe Emese"),
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
