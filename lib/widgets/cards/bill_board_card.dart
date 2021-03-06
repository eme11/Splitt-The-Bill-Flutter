import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/bill_board.dart';
import '../../scoped_models/main_model.dart';

class BillBoardCard extends StatefulWidget {
  BillBoard value;
  double _percent;
  int index;

  BillBoardCard(this.value, this.index);

  @override
  State<StatefulWidget> createState() {
    return _BillBoardCardState();
  }
}

class _BillBoardCardState extends State<BillBoardCard> {
  Widget _buildTrailing() {
    return widget.value.type == false
        ? Text('')
        : ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Vote(Yes/No)"),
                FlatButton(
                  child: Icon(Icons.done),
                  onPressed: () {
                    model.incrementPoll(widget.index);
                  },
                ),
                FlatButton(
                  child: Icon(Icons.not_interested),
                  onPressed: () {
                    model.incrementPoll(widget.index, yes: false);
                  },
                )
              ],
            );
          });
  }

  String _getPublisher() {
    return widget.value.userNickName == null
        ? 'unknown user'
        : widget.value.userNickName;
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(widget.value.descrition),
        Text('Published by: ' + _getPublisher())
      ],
    );
  }

  Widget _buildPollVote() {
    widget._percent = widget.value.yesVote == 0 && widget.value.noVote == 0
        ? 0.0
        : (widget.value.yesVote / (widget.value.noVote + widget.value.yesVote));

    return widget.value.type == false
        ? Text('')
        : LinearPercentIndicator(
            lineHeight: 10.0,
            percent: widget._percent,
            backgroundColor: Theme.of(context).textSelectionColor,
            progressColor: Theme.of(context).primaryColor,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.value.title),
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
