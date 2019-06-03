import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../scoped_models/main_model.dart';
import '../../models/user.dart';

class UserSplitListTitle extends StatelessWidget {
  final double percentage;
  final User user;

  UserSplitListTitle(this.user, this.percentage);

  String _getInitials(String firstName, String lastName) {
    return firstName[0].toUpperCase() + lastName[0].toUpperCase();
  }

  Widget _linearPercentIndicator() {
    return LinearPercentIndicator(
      lineHeight: 20.0,
      percent: percentage,
      backgroundColor: Colors.red,
      progressColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          child: Text(_getInitials(user.firstName, user.lastName)),
        ),
        title: Column(
          children: <Widget>[
            Text(user.firstName + ' ' + user.lastName),
            _linearPercentIndicator(),
          ],
        ));
  }
}
