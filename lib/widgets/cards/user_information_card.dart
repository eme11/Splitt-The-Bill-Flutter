import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserInfoCard extends StatelessWidget {
  final User information;
  final Function delete;
  final Function deleteAid;

  UserInfoCard(this.information, {this.delete, this.deleteAid});

  String _getInitials() {
    return information.firstName[0].toUpperCase() +
        information.lastName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String _intials = _getInitials();
    return Container(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text(_intials)),
          title: Text(information.firstName + ' ' + information.lastName),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(information.nickName),
              Text(information.email),
              Text(information.phone)
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              delete(information, deleteAid);
            },
          ),
        ),
      ),
    );
  }
}
