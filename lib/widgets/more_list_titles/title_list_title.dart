import 'package:flutter/material.dart';
import '../../pop_up_widows/apparment_create.dart';

import '../../models/apartment.dart';

class TitleListTitle extends StatelessWidget {
  final Apartment title;
  final IconData icon;
  final ApartmentCreate page;

  TitleListTitle(this.title, this.icon, this.page);

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title.getAddress()),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
                context: context, builder: (BuildContext context) => page);
          },
        ),
      ),
    );
  }
}
