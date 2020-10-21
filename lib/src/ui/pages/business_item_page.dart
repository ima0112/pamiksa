import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class BusinessItemPage extends StatefulWidget {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  double valoration;
  double deliveryPrice;

  BusinessItemPage(
      {this.id,
      this.name,
      this.description,
      this.adress,
      this.phone,
      this.email,
      this.photo,
      this.deliveryPrice,
      this.valoration});

  @override
  _BusinessItemPageState createState() => _BusinessItemPageState();
}

class _BusinessItemPageState extends State<BusinessItemPage> {
  final NavigationService navigationService = locator<NavigationService>();
  HomeBloc homeBloc;
  BusinessDetailsBloc businessDetailsBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    businessDetailsBloc = BlocProvider.of<BusinessDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
//                  CircleAvatar(
//                    radius: 17.5,
//                    backgroundColor: Colors.transparent,
//                    backgroundImage: AssetImage("assets/images/profile.png"),
//                  ),
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.5),
                      child: Image.network(
                        this.widget.photo,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
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
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    text: "${this.widget.adress}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        fontSize: 12)),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                    flex: 4,
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
                                            color: Theme.of(context)
                                                .backgroundColor,
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
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                businessDetailsBloc
                    .add(FetchBusinessDetailsEvent(this.widget.id));
                navigationService.navigateTo(Routes.BussinesDetailsRoute);
              },
              child: FadeInImage(
                width: 500,
                fit: BoxFit.cover,
                height: 225,
                placeholder: AssetImage("assets/gif/loading.gif"),
                image: NetworkImage(this.widget.photo),
              ),
            ),
            IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
                color: Colors.white,
                splashRadius: 1.0)
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
                        color: Theme.of(context).backgroundColor,
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
