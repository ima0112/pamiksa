import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src//shared/servidor.dart' show URL, ACCESS_TOKEN;
import 'package:pamiksa/src//shared/widget/waveclipper.dart';
import 'file:///C:/Users/Imandra/AndroidStudioProjects/pamiksa/lib/src/providers/themes/consts.dart';
import 'package:pamiksa/src/ui/login/loginF.dart';
import 'package:pamiksa/src/ui/register/register_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  static const URI = '/login';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Login();
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginP();
}

class LoginP extends State<Login> {
  static HttpLink httplink =
      HttpLink(uri: URL, headers: {'AccessToken': ACCESS_TOKEN});

  ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: InMemoryCache(), link: httplink));

  String msg = '';
  bool valid = true;
  SharedPreferences _prefs;
  String token;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() {
          this._prefs = prefs;
          loadToken();
          if (token != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Register()));
          }
        });
      });
  }

  loadToken() async {
    setState(() {
      this.token = _prefs.getString('token') ?? null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: CacheProvider(
            child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                brightness: Brightness.dark,
              )),
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipper2(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff7C4DFF), Color(0xff6200EA)])),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper3(),
                    child: Container(
                      child: Column(),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff6200EA), Color(0xff5C4DFF)])),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper1(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.fastfood,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Pamiksa',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          )
                        ],
                      ),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff6200EA), Color(0xff7C4DFF)])),
                    ),
                  )
                ],
              ),
              FormLogin(),
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(
                  '¿ Olvidó su contraseña ?',
                  style: TextStyle(
                      color: Color(0xff6200EA),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿ No tiene un usuario ? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  GestureDetector(
                    child: Text(
                      "Regístrate",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      Navigator.of(context).push(_createRouter());
                    },
                  )
                ],
              )
            ],
          ),
        )));
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Register(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      });
}
