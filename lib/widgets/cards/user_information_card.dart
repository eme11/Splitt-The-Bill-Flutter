import 'package:flutter/material.dart';
import '../../models/user.dart';
class UserInfoCard extends StatelessWidget {
  final User information;

  UserInfoCard(this.information);

  String _getInitials() {
    return information.firstName[0].toUpperCase() + information.lastName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String _intials = _getInitials();
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(_intials)),
        title: Text(information.firstName + ' ' + information.lastName),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text(information.nickName), Text(information.email), Text(information.phone)],
        ),
      ),
    );
  }
}
