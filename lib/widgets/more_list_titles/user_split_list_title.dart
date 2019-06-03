import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../models/user.dart';
import '../ui_elements/price_tag.dart';

class UserSplitListTitle extends StatelessWidget {
  final double percentage;
  final double ammount;
  final User user;

  UserSplitListTitle(this.user, this.percentage, this.ammount);

  Widget _linearPercentIndicator(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 15.0,
      percent: percentage,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      progressColor: Theme.of(context).primaryColor,
      center: Text((percentage * 100).toString() + '%'),
      trailing: PriceTag(ammount, horizontal: 3, vertical: 1.25,)

    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.firstName + ' ' + user.lastName),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          _linearPercentIndicator(context)
        ],
      ),
    );
  }
}
