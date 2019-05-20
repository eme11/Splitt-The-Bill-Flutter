import 'package:flutter/material.dart';

class UserListTitle extends StatefulWidget {
  final String firstName;
  final String lastName;
  final Function openNewPage;
  final Widget page;

  UserListTitle(this.firstName, this.lastName, this.openNewPage, this.page);

  @override
  State<StatefulWidget> createState() {
    return _UserListTitleState();
  }
}

class _UserListTitleState extends State<UserListTitle>{

  String _getInitials() {
    return widget.firstName[0].toUpperCase() + widget.lastName[0].toUpperCase();
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
        title: Text(widget.firstName + ' ' + widget.lastName),
        subtitle: Text('Account Information'),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {widget.openNewPage(context, widget.page);},
        ),
      ),
    );
  }
}
