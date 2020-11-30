import 'package:flutter/material.dart';

class FoodItemSkeletonPage extends StatefulWidget {
  @override
  _FoodItemSkeletonPageState createState() => _FoodItemSkeletonPageState();
}

class _FoodItemSkeletonPageState extends State<FoodItemSkeletonPage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      title: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 60,
          height: 10,
          color: Theme.of(context).chipTheme.backgroundColor,
        ),
      ),
      onTap: () {},
      subtitle: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 40,
          height: 10,
          color: Theme.of(context).chipTheme.backgroundColor,
        ),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7.5),
        child: Container(
          width: 80,
          height: 60,
          color: Theme.of(context).chipTheme.backgroundColor,
        ),
      ),
      dense: true,
    );
  }
}
