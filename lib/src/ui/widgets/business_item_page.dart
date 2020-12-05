import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class BusinessItemPage extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String adress;
  final String phone;
  final String email;
  final String photo;
  final String photoUrl;
  final double valoration;
  final double deliveryPrice;

  BusinessItemPage(
      {this.id,
      this.name,
      this.description,
      this.adress,
      this.phone,
      this.email,
      this.photo,
      this.photoUrl,
      this.deliveryPrice,
      this.valoration});

  @override
  _BusinessItemPageState createState() => _BusinessItemPageState();
}

class _BusinessItemPageState extends State<BusinessItemPage> {
  final NavigationService navigationService = locator<NavigationService>();
  RootBloc homeBloc;
  BusinessDetailsBloc businessDetailsBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<RootBloc>(context);
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
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.5),
                      child: FadeInImage(
                        width: 100,
                        fit: BoxFit.cover,
                        height: 100,
                        placeholder:
                            (Theme.of(context).brightness == Brightness.dark)
                                ? AssetImage("assets/gif/dark_loading.gif")
                                : AssetImage("assets/gif/loading.gif"),
                        image: NetworkImage(this.widget.photoUrl),
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
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color,
                                  fontWeight: FontWeight.bold),
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    width: 500,
                    fit: BoxFit.cover,
                    height: 225,
                    placeholder:
                        (Theme.of(context).brightness == Brightness.dark)
                            ? AssetImage("assets/gif/dark_loading.gif")
                            : AssetImage("assets/gif/loading.gif"),
                    image: NetworkImage(this.widget.photoUrl),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Costo de envio: ${this.widget.deliveryPrice} CUP",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "Horario: 7:30AM - 8:00PM",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
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
