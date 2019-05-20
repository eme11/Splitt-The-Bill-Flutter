import 'package:flutter/material.dart';

class SimpleListTitle extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function openNewPage;
  final Widget page;

  // later add function parameter

  SimpleListTitle(this.title, this.icon, {this.openNewPage, this.page});

  @override
  State<StatefulWidget> createState() {
    return _SimpleListTitleState();
  }
}

class _SimpleListTitleState extends State<SimpleListTitle> {
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
              widget.openNewPage(context, widget.page);
            }
          },
        ),
      ),
    );
  }
}
