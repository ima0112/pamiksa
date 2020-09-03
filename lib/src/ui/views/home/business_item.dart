import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'file:///C:/Users/Developer/Projects/pamiksa/lib/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/data/models/business_owner.dart';

class BusinessItem extends StatefulWidget {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  BusinessOwnersModel businessOwnerFk;
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
      this.businessOwnerFk,});

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
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "${this.widget.name}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    text: "${this.widget.adress}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12)),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                    flex: 4,
                  ),
                  /*Spacer(
                    flex: 1,
                  ),*/
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
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: <Widget>[
            FadeInImage(
              placeholder: AssetImage("assets/images/pizza.jpg"),
              image: NetworkImage("http://192.168.0.2:8000/images/${this.widget.photo}"),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child:
                    Icon(Icons.favorite_border, color: Colors.white, size: 25)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Container(
            //color: Colors.deepPurpleAccent,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Horario: 7:30AM - 8:00PM",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
