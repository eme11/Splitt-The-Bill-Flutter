import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BillBoardCard extends StatefulWidget {
  final Map<String, dynamic> value;
  int _okayScore = 0;
  int _noScore = 0;
  double _percent;

  BillBoardCard(this.value);

  @override
  State<StatefulWidget> createState() {
    return _BillBoardCardState();
  }
}

class _BillBoardCardState extends State<BillBoardCard> {
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
                  setState(() {
                    widget._okayScore = widget._okayScore + 1;
                  });
                },
              ),
              FlatButton(
                child: Icon(Icons.not_interested),
                onPressed: () {
                  setState(() {
                    widget._noScore = widget._noScore + 1;
                  });
                },
              )
            ],
          );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(widget.value['description']),
        Text('Published by: ' + widget.value['user'])
      ],
    );
  }

  Widget _buildPollVote() {
    widget._percent = widget._okayScore == 0 && widget._noScore == 0 ? 0.0 : widget._okayScore / (widget._noScore + widget._okayScore);

    return widget.value['type'] == false
        ? Text('')
        : LinearPercentIndicator(
            lineHeight: 10.0,
            percent: widget._percent,
            backgroundColor: Colors.red,
            progressColor: Colors.green,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.value['title']),
            subtitle: _buildDescription(),
          ),
          Container(
            child: _buildTrailing(),
          ),
          Container(
            child: _buildPollVote(),
          )
        ],
      ),
    );
  }
}
