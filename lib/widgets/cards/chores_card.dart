import 'package:flutter/material.dart';
import '../../models/chores.dart';

class ChoresCard extends StatefulWidget {
  Chore value;

  ChoresCard(this.value);

  @override
  State<StatefulWidget> createState() {
    return _ChoresCardState();
  }
}

class _ChoresCardState extends State<ChoresCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Text('EM'),
            ),
            title: Text(widget.value.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(widget.value.description),
                //Text('Person resposible: ' + widget.value['user']),
                Text('Changing Interval: ' +
                    widget.value.changingInterval.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
