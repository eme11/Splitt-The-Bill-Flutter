import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double horizontal;
  final double vertical;

  PriceTag(this.price, {this.horizontal = 6.0, this.vertical = 2.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        '\$' + price.toStringAsFixed(2),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
