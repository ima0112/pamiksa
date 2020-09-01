import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:pamiksa/src/blocs/home_bloc.dart';

class BusinessItem extends StatefulWidget {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  String businessOwnerFk;
  String provinceFk;
  String municipalityFk;
  double valoration;
  double deliveryPrice;

  BusinessItem(
      {this.id,
      this.name,
      this.description,
      this.adress,
      this.phone,
      this.email,
      this.photo,
      this.deliveryPrice,
      this.valoration,
      this.businessOwnerFk,
      this.provinceFk,
      this.municipalityFk});

  @override
  _BusinessItemState createState() => _BusinessItemState();
}

class _BusinessItemState extends State<BusinessItem> {
  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            children: <Widget>[
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${this.widget.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          builder: (context) => Container(
                                height: 200,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      )),
                                  child: Center(
                                    child: Text("Probando"),
                                  ),
                                ),
                              )),
                      borderRadius: BorderRadius.circular(15),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      text: TextSpan(text: "${this.widget.adress}", style: TextStyle(color: Colors.black)),
                    ),
                  )
                ],
              ),*/
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "${this.widget.name}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(text: "${this.widget.adress}", style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    flex: 9,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                builder: (context) => Container(
                                      height: 200,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(25.0),
                                              topRight:
                                                  const Radius.circular(25.0),
                                            )),
                                        child: Center(
                                          child: Text("Probando"),
                                        ),
                                      ),
                                    )),
                            borderRadius: BorderRadius.circular(15),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            ],
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Stack(
          children: <Widget>[
            Image.asset("assets/images/${this.widget.photo}"),
            Positioned(
                bottom: 15,
                right: 15,
                child:
                    Icon(Icons.favorite_border, color: Colors.white, size: 25)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Costo de envio: ${this.widget.deliveryPrice} CUP",
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[200],
                      child: Text(
                        "${this.widget.valoration}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
      ],
    );
  }
}
