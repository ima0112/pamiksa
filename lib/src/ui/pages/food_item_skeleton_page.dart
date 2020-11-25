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
      title: Text(
        'test',
        style: TextStyle(fontSize: 14.0),
      ),
      onTap: () {},
      subtitle: Text(
        'test',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7.5),
        child: Image.network(
          'test',
          fit: BoxFit.fitWidth,
          width: 80,
        ),
      ),
      dense: true,
    );
  }
}
