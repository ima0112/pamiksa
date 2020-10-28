import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final NavigationService navigationService = locator<NavigationService>();
  ProfileBloc profileBloc;

  List<String> options = ["Cambiar contraseña"];

  @override
  Widget build(BuildContext context) {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Perfil",
      //     style: TextStyle(
      //         color: Theme.of(context).textTheme.bodyText1.color,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 2.0,
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.more_vert),
      //         onPressed: () {
      //           modalButtonSheet();
      //         })
      //   ],
      // ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            automaticallyImplyLeading: false,
            elevation: 0.0,
          )),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previousState, state) =>
                state.runtimeType != previousState.runtimeType,
            builder: (context, state) {
              if (state is ProfileInitial) {
                profileBloc.add(FetchProfileEvent());
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is LoadedProfileState) {
                Widget profileCircleAvatar() {
                  if (state.results.photo != null) {
                    return CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        'http://192.168.0.50:9000/user-avatar/${state.results.photo}',
                      ),
                    );
                  }
                  return CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                        "assets/images/image_color_gray_transparent_background.png"),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        title: Text(
                          "Perfil",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              fontWeight: FontWeight.bold),
                        ),
                        elevation: 2.0,
                        actions: [
                          IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                modalButtonSheet();
                              })
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: <Widget>[
                              profileCircleAvatar(),
                              Container(
                                decoration: ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Theme.of(context).primaryColor),
                                child: IconButton(
                                    icon: Icon(Icons.photo_camera),
                                    onPressed: () {
                                      navigationService
                                          .navigateTo("/pick_image");
                                    },
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        isThreeLine: true,
                        title: Text(
                          "Nombre",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14.0),
                        ),
                        subtitle: Text(
                          state.results.fullName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        onTap: () => showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    height: 200.0,
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
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25.0, 25.0, 25.0, 0.0),
                                                child: Text(
                                                  "Introduce tu nombre",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25.0, 10.0, 25.0, 0.0),
                                                child: TextFormField(
                                                  initialValue:
                                                      state.results.fullName,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  maxLength: 40,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  decoration:
                                                      const InputDecoration(
                                                    helperText: "",
                                                    border:
                                                        UnderlineInputBorder(),
                                                    // labelText: 'Correo electrónico',
                                                    filled: false,
                                                    //icon: Icon(Icons.email),
                                                  ),
                                                  onChanged: (String value) {
                                                    state.results.fullName =
                                                        value;
                                                  },
                                                  //validator: (value) => validateEmail(value),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25.0, 10.0, 4.0, 0.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FlatButton(
                                                      child: Text(
                                                        "Cancelar",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        "Aceptar",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      onPressed: () {},
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                )),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        isThreeLine: true,
                        title: Text(
                          "Direccion",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14.0),
                        ),
                        subtitle: Text(
                          state.results.adress,
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        onTap: () {},
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        isThreeLine: true,
                        title: Text(
                          "Correo Electronico",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14.0),
                        ),
                        subtitle: Text(
                          state.results.email,
                          style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              }
              return Container(
                child: Center(
                  child: Text("Error"),
                ),
              );
            },
          );
        },
      ),
    );
  }

  modalButtonSheet() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 200.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      )),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${options[index]}"),
                          onTap: () {
                            navigationService
                                .navigateWithoutGoBack(Routes.ChangePassword);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
