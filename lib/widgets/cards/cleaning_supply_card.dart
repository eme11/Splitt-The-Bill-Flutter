import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main_model.dart';

import '../ui_elements/price_tag.dart';
import '../../models/cleaning_suppliy.dart';

class CleaningSupplyCard extends StatefulWidget {
  CleainingSupply value;

  CleaningSupplyCard(this.value);

  @override
  State<StatefulWidget> createState() {
    return _CleaningSupplyCardState();
  }
}

class _CleaningSupplyCardState extends State<CleaningSupplyCard> {
  IconData _getIcon() {
    IconData icon = null;
    if (widget.value.type == 'Bathroom') {
      icon = Icons.invert_colors;
    } else if (widget.value.type == 'Kitchen') {
      icon = Icons.free_breakfast;
    } else if (widget.value.type == 'Living') {
      icon = Icons.event_seat;
    } else {
      icon = Icons.more_horiz;
    }

    return icon;
  }

  String _getBuyer() {
    return widget.value.buyerNickName == null
        ? 'anonymous user'
        : widget.value.buyerNickName;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: Column(
          children: <Widget>[
            ListTile(
                leading: CircleAvatar(child: Icon(_getIcon())),
                title: Text(widget.value.name),
                subtitle: Text('Buyer: ' + _getBuyer()),
                trailing: PriceTag(widget.value.price))
          ],
        ),
      );
    });
  }
}
