import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final NavigationService navigationService = locator<NavigationService>();
  ProfileBloc profileBloc;

  String fullname;
  String adress;
  String email;

  @override
  Widget build(BuildContext context) {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previousState, state) =>
            state.runtimeType != previousState.runtimeType,
        builder: (context, state) {
          if (state is ProfileInitial) {
            profileBloc.add(FetchProfileEvent());
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Perfil",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state is LoadingProfileState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Perfil",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state is ProfileTokenExpiredState) {
            profileBloc.add(ProfileRefreshTokenEvent());
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Perfil",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state is LoadedProfileState) {
            Widget profileCircleAvatar() {
              if (state.results.photoUrl != null) {
                return CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    state.results.photoUrl,
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

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Perfil",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
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
                                    navigationService.navigateTo("/pick_image");
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
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.0),
                      ),
                      subtitle: Text(
                        state.results.fullName,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      onTap: () {
                        changeName(state.results.fullName);
                      },
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
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.0),
                      ),
                      subtitle: Text(
                        state.results.adress,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      onTap: () {
                        changeAdress(state.results.adress);
                      },
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
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.0),
                      ),
                      subtitle: Text(
                        state.results.email,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      profileBloc.add(SetProfileInitialStateEvent());
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Reintentar")));
          }
        });
  }

  changeName(String fullname) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 190.0,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
                          child: Text(
                            "Introduce tu nombre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                          child: TextFormField(
                            autofocus: true,
                            initialValue: fullname,
                            keyboardType: TextInputType.name,
                            maxLength: 40,
                            style: TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              helperText: "",
                              border: UnderlineInputBorder(),
                              // labelText: 'Correo electrónico',
                              filled: false,
                              //icon: Icon(Icons.email),
                            ),
                            onChanged: (String value) {
                              this.fullname = value;
                            },
                            //validator: (value) => validateEmail(value),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 4.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text(
                                  "Aceptar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  profileBloc.add(
                                      ChangeNameEvent(name: this.fullname));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ));
  }

  changeAdress(String adress) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 190.0,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
                          child: Text(
                            "Introduce tu direccion",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                          child: TextFormField(
                            autofocus: true,
                            initialValue: adress,
                            keyboardType: TextInputType.text,
                            maxLength: 80,
                            style: TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              helperText: "",
                              border: UnderlineInputBorder(),
                              // labelText: 'Correo electrónico',
                              filled: false,
                              //icon: Icon(Icons.email),
                            ),
                            onChanged: (String value) {
                              this.adress = value;
                            },
                            //validator: (value) => validateEmail(value),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 4.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text(
                                  "Aceptar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  profileBloc.add(
                                      ChangeAdressEvent(adress: this.adress));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ));
  }

  changeEmail(String email) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 190.0,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
                          child: Text(
                            "Introduce tu nombre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                          child: TextFormField(
                            autofocus: true,
                            initialValue: email,
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 40,
                            style: TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              helperText: "",
                              border: UnderlineInputBorder(),
                              // labelText: 'Correo electrónico',
                              filled: false,
                              //icon: Icon(Icons.email),
                            ),
                            onChanged: (String value) {
                              this.email = value;
                            },
                            //validator: (value) => validateEmail(value),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 10.0, 4.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text(
                                  "Aceptar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  profileBloc
                                      .add(ChangeEmailEvent(email: this.email));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ));
  }
}
