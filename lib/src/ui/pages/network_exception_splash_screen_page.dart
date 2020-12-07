import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/network_exception_splash_screen/network_exception_splash_screen_bloc.dart';

class NetworkExceptionSplashScreen extends StatefulWidget {
  @override
  _NetworkExceptionSplashScreenState createState() =>
      _NetworkExceptionSplashScreenState();
}

class _NetworkExceptionSplashScreenState
    extends State<NetworkExceptionSplashScreen> {
  NetworkExceptionSplashScreenBloc networkExceptionSplashScreenBloc;

  void initState() {
    networkExceptionSplashScreenBloc =
        BlocProvider.of<NetworkExceptionSplashScreenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkExceptionSplashScreenBloc,
        NetworkExceptionSplashScreenState>(builder: (context, state) {
      if (state is NetworkExceptionSplashScreenInitialState) {
        return Scaffold(
          body: SafeArea(
            top: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 12.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    "Parece que tienes problemas en la conexión. Compruébalo y prueba otra vez.",
                    style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ),
                FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      networkExceptionSplashScreenBloc.add(CheckSessionEvent());
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Reintentar"))
              ],
            ),
          ),
        );
      } else if (state is LoadingCheckSessionState) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Center(child: CircularProgressIndicator())],
          ),
        );
      } else {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 12.5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Text(
                  "Parece que tienes problemas en la conexión. Compruébalo y prueba otra vez.",
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                  label: Text("Reintentar"))
            ],
          ),
        );
      }
    });
  }
}
