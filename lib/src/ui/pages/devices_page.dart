import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/devices/devices_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  DevicesBloc devicesBloc;
  final NavigationService navigationService = locator<NavigationService>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    devicesBloc = BlocProvider.of<DevicesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        bottom: PreferredSize(
            child: AppBar(
              title: Text(
                "Dispositivos",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              elevation: 2.0,
            ),
            preferredSize: Size.fromHeight(0)),
      ),
      body: BlocBuilder<DevicesBloc, DevicesState>(
        builder: (context, state) {
          return BlocBuilder<DevicesBloc, DevicesState>(
              buildWhen: (previousState, state) =>
                  state.runtimeType != previousState.runtimeType,
              builder: (context, state) {
                if (state is DevicesInitial) {
                  devicesBloc.add(FetchDevicesDataEvent());
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadingDeviceData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedDevicesState &&
                    state.results != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Sesion Actual",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(state.deviceModel.model),
                        subtitle: Text(
                            "${state.deviceModel.plattform} ${state.deviceModel.systemVersion}"),
                        onTap: () {},
                      ),
                      Divider(
                        height: 0.0,
                      ),
                      ListTile(
                        title: Text(
                          "Cerrar las demas sesiones",
                          style: TextStyle(color: Colors.red[900]),
                        ),
                        onTap: () {
                          AlertDialog alertDialog = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              content: Container(
                                  //color: Colors.grey,
                                  height: 150,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Cerrar Sesión",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "¿Estás seguro que deseas cerrar las demas sesiones?",
                                            textAlign: TextAlign.center,
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Cancelar"),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                devicesBloc
                                                    .add(SignOutAllEvent());
                                                Navigator.pop(context);
                                              },
                                              color:
                                                  Colors.deepPurpleAccent[700],
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                "Cerrar Sesión",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )));
                          showDialog(context: context, child: alertDialog);
                        },
                      ),
                      Divider(
                        height: 5.0,
                        thickness: 5.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Otros Dispositivos",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: state.results.length,
                        itemBuilder: (_, index) => ListTile(
                          title: Text(state.results[index].model),
                          subtitle: Text(
                              "${state.results[index].plattform} ${state.results[index].systemVersion}"),
                          onTap: () {
                            AlertDialog alertDialog = AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                content: Container(
                                    //color: Colors.grey,
                                    height: 150,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Cerrar Sesión",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "¿Estás seguro que deseas cerrar esta sesión?",
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancelar"),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  devicesBloc.add(SignOutEvent(
                                                      state.results[index]
                                                          .deviceId));
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                color: Colors
                                                    .deepPurpleAccent[700],
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  "Cerrar Sesión",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )));
                            showDialog(context: context, child: alertDialog);
                          },
                          trailing: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red[900],
                          ),
                        ),
                        separatorBuilder: (_, __) =>
                            Divider(height: 0.0, indent: 15.0),
                      )
                    ],
                  );
                } else if (state is LoadedDevicesState &&
                    state.results == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Sesion Actual",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(state.deviceModel.model),
                        subtitle: Text(
                            "${state.deviceModel.plattform} ${state.deviceModel.systemVersion}"),
                        onTap: () {},
                      ),
                    ],
                  );
                } else if (state is SignOutAllState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Sesion Actual",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(state.deviceModel.model),
                        subtitle: Text(
                            "${state.deviceModel.plattform} ${state.deviceModel.systemVersion}"),
                        onTap: () {},
                      ),
                    ],
                  );
                } else if (state is SignOutState && state.results != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Sesion Actual",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(state.deviceModel.model),
                        subtitle: Text(
                            "${state.deviceModel.plattform} ${state.deviceModel.systemVersion}"),
                        onTap: () {
                          AlertDialog alertDialog = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              content: Container(
                                  //color: Colors.grey,
                                  height: 150,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Cerrar Sesión",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "¿Estás seguro que deseas cerrar esta sesión?",
                                            textAlign: TextAlign.center,
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Cancelar"),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                devicesBloc
                                                    .add(SignOutAllEvent());
                                                Navigator.pop(context);
                                              },
                                              color:
                                                  Colors.deepPurpleAccent[700],
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                "Cerrar Sesión",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )));
                          showDialog(context: context, child: alertDialog);
                        },
                      ),
                      Divider(
                        height: 0.0,
                      ),
                      ListTile(
                        title: Text(
                          "Cerrar las demas sesiones",
                          style: TextStyle(color: Colors.red[900]),
                        ),
                        onTap: () {
                          AlertDialog alertDialog = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              content: Container(
                                  //color: Colors.grey,
                                  height: 150,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Cerrar Sesión",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "¿Estás seguro que deseas cerrar las demas sesiones?",
                                            textAlign: TextAlign.center,
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Cancelar"),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                devicesBloc
                                                    .add(SignOutAllEvent());
                                                Navigator.pop(context);
                                              },
                                              color:
                                                  Colors.deepPurpleAccent[700],
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                "Cerrar Sesión",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )));
                          showDialog(context: context, child: alertDialog);
                        },
                      ),
                      Divider(
                        height: 5.0,
                        thickness: 5.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Otros Dispositivos",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: state.results.length,
                        itemBuilder: (_, index) => ListTile(
                          title: Text(state.results[index].model),
                          onTap: () {
                            AlertDialog alertDialog = AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                content: Container(
                                    //color: Colors.grey,
                                    height: 150,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Cerrar Sesión",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "¿Estás seguro que deseas cerrar esta sesión?",
                                              textAlign: TextAlign.center,
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancelar"),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  devicesBloc.add(SignOutEvent(
                                                      state.results[index]
                                                          .deviceId));
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                color: Colors
                                                    .deepPurpleAccent[700],
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  "Cerrar Sesión",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )));
                            showDialog(context: context, child: alertDialog);
                          },
                          subtitle: Text(
                              "${state.results[index].plattform} ${state.results[index].systemVersion}"),
                          trailing: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red[900],
                          ),
                        ),
                        separatorBuilder: (_, __) =>
                            Divider(height: 0.0, indent: 15.0),
                      )
                    ],
                  );
                } else if (state is SignOutState && state.results == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Sesion Actual",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(state.deviceModel.model),
                        subtitle: Text(
                            "${state.deviceModel.plattform} ${state.deviceModel.systemVersion}"),
                        onTap: () {},
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: Text(
                          "Parece que tienes un problema con la conexion..."));
                }
              });
        },
      ),
    );
  }
}
