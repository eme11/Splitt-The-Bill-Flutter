import 'package:flutter/material.dart';

class BillBoardCard extends StatefulWidget {
  final Map<String, dynamic> value;
  int _okayScore = 0;
  int _noScore = 0;

  BillBoardCard(this.value);

  @override
  State<StatefulWidget> createState() {
    return _BillBoardCardState();
  }
}

class _BillBoardCardState extends State<BillBoardCard>{

  Widget _buildTrailing() {
    return widget.value['type'] == false
        ? Text('')
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Vote(Yes/No)"),
              FlatButton(
                child: Icon(Icons.done),
                onPressed: () {
                  widget._okayScore =  widget._okayScore + 1;
                },
              ),
              FlatButton(
                child: Icon(Icons.not_interested),
                onPressed: () {
                  widget._noScore =  widget._noScore + 1;
                },
              )
            ],
          );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text( widget.value['description']),
        Text('Published by: ' +  widget.value['user'])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text( widget.value['title']),
            subtitle: _buildDescription(),
          ),
          Container(
            child: _buildTrailing(),
          )
        ],
      ),
    );
  }
}
