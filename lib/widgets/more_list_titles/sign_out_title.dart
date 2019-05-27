import 'package:flutter/material.dart';

class SignOutListTitle extends StatefulWidget {
  final String title;
  final IconData icon;
  final String page;

  // later add function parameter

  SignOutListTitle(this.title, this.icon, this.page);

  @override
  State<StatefulWidget> createState() {
    return _SignOutListTitleState();
  }
}

class _SignOutListTitleState extends State<SignOutListTitle> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(widget.icon)),
        title: Text(widget.title),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            if (widget.page != null) {
              Navigator.pushReplacementNamed(context, widget.page);
            }
          },
        ),
      ),
    );
  }
}
