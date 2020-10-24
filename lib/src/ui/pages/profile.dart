import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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

  @override
  Widget build(BuildContext context) {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
        elevation: 2.0,
      ),
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
                        'http://192.168.1.2:9000/user-avatar/${state.results.photo}',
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

                return Column(
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
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      onTap: () {},
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
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.0),
                      ),
                      subtitle: Text(
                        state.results.email,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      onTap: () {},
                    ),
                  ],
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
}