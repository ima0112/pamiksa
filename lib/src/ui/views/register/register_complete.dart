import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/register_complete/register_complete_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

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
                        ))
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
}
