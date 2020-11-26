import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_complete/register_complete_bloc.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class RegisterCompletePage extends StatefulWidget {
  @override
  _RegisterCompletePageState createState() => _RegisterCompletePageState();
}

class _RegisterCompletePageState extends State<RegisterCompletePage> {
  final NavigationService navigationService = locator<NavigationService>();

  UserModel userModel = UserModel();
  RegisterCompleteBloc registerCompleteBloc;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    registerCompleteBloc = BlocProvider.of<RegisterCompleteBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColorLight,
            brightness: Theme.of(context).appBarTheme.brightness,
          )),
      body:
          // WillPopScope(
          //   onWillPop: () async {
          //     navigationService.navigateAndRemove(Routes.LoginRoute);
          //     return false;
          //   },
          //   child:
          WillPopScope(
        onWillPop: () async {
          navigationService.navigateAndRemove(Routes.LoginRoute);
          return false;
        },
        child: Container(
          child: Column(
            children: <Widget>[
              registroText(),
              SizedBox(
                height: 50,
              ),
              Expanded(flex: 3, child: infoText()),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                    height: 45,
                    width: 320,
                    child: BlocBuilder<RegisterCompleteBloc,
                        RegisterCompleteState>(
                      builder: (context, state) {
                        if (state is RegistercompleteInitial) {
                          return RaisedButton(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              registerCompleteBloc
                                  .add(MutateUserandDeviceEvent(userModel));
                            },
                            child: Text(
                              'REGISTRARME',
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  fontWeight: FontWeight.w900),
                            ),
                          );
                        }
                        if (state is SendingUserandDeviceDataState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
      // )
    );
  }

  Widget registroText() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FittedBox(
            child: Text(
              "Registrarme",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget infoText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Text.rich(
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
      ),
    );
  }
}
