import 'package:flutter/material.dart';

class UserListTitle extends StatelessWidget {
  final String firstName;
  final String lastName;

  UserListTitle(this.firstName, this.lastName);

  String _getInitials() {
    return firstName[0].toUpperCase() + lastName[0].toUpperCase();
  }

  // for later:
  // change to stteful widget and add on pressed and redirecting to new page
  @override
  Widget build(BuildContext context) {
    final String initials = _getInitials();
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(initials),
        ),
        title: Text(firstName + ' ' + lastName),
        subtitle: Text('Account Information'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
