import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/graphqlConfig.dart';
import 'package:pamiksa/src/data/graphql/mutations/sendDeviceInfo.dart';
import 'package:pamiksa/src/data/graphql/mutations/signUp.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCompletePage extends StatefulWidget {
  @override
  _RegisterCompletePageState createState() => _RegisterCompletePageState();
}

class _RegisterCompletePageState extends State<RegisterCompletePage> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  User user = User();
  Device device = Device();
  String id;

  void initState() {
    super.initState();
    fetchData();
    obtenerPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: CacheProvider(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: Color(0xffF5F5F5),
                  brightness: Brightness.light,
                )),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 50.0),
                child: Column(
                  children: <Widget>[
                    registroText(),
                    SizedBox(
                      height: 50,
                    ),
                    infoText(),
                    Spacer(
                      flex: 1,
                    ),
                    Container(
                      height: 45,
                      width: 320,
                      child: Mutation(
                        options:
                            MutationOptions(documentNode: gql(sendDeviceInfo)),
                        builder: (RunMutation runMutation, QueryResult result) {
                          return RaisedButton(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              // runMutation({
                              //   'platform': device.platform,
                              //   'systemVersion': device.systemVersion,
                              //   'deviceId': device.deviceId,
                              //   'model': device.model,
                              //   'userFk': id
                              // });
                              print(id);
                              // Navigator.of(context)
                              //     .pushReplacement(ruta.createRouter(LoginPage()));
                            },
                            child: Text(
                              'REGISTRARME',
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  fontWeight: FontWeight.w900),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget registroText() {
    return Container(
      child: Text(
        "Registrarme",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget infoText() {
    return Text.rich(
      TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          children: <TextSpan>[
            TextSpan(text: 'Al registrarse acepta nuestras '),
            TextSpan(
                text: 'políticas de privacidad',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                )),
            TextSpan(text: ' y '),
            TextSpan(
                text: 'condiciones de uso.',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ))
          ]),
      textAlign: TextAlign.center,
    );
  }

  void obtenerPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('user_id');
  }

  void fetchData() async {
    await initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          device.platform = "Android";
          device.deviceId = androidInfo.id;
          device.model = '${androidInfo.brand} ' + '${androidInfo.model}';
          device.systemVersion = androidInfo.version.release;
        });
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
