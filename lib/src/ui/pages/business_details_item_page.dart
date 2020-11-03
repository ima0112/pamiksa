import 'package:flutter/material.dart';

class BusinessDetailsItemPage extends StatefulWidget {
  final String id;
  final String name;
  final double price;
  final String photo;
  final bool isAvailable;
  final int availability;

  BusinessDetailsItemPage(
      {this.id,
      this.name,
      this.price,
      this.photo,
      this.availability,
      this.isAvailable});

  @override
  _BusinessDetailsItemPageState createState() =>
      _BusinessDetailsItemPageState();
}

class _BusinessDetailsItemPageState extends State<BusinessDetailsItemPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      title: Text(
        "${widget.name}",
        style: TextStyle(fontSize: 14.0),
      ),
      onTap: () {},
      subtitle: Text("Precio: ${widget.price}"),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(7.5),
        child: Image.network(
          widget.photo,
          fit: BoxFit.fitHeight,
          height: 100,
        ),
      ),
      dense: true,
    );
  }
}
