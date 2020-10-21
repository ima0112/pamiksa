import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            builder: (context, state) => ProfileActions(),
          );
        },
      ),
    );
  }
}

class ProfileActions extends StatefulWidget {
  @override
  _ProfileActionsState createState() => _ProfileActionsState();
}

class _ProfileActionsState extends State<ProfileActions> {
  ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    final ProfileState currentState = profileBloc.state;
    if (profileBloc.state is ProfileInitial) {
      profileBloc.add(FetchProfileEvent());
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (currentState is LoadedProfileState) {
      final meData = currentState.results;
      return Column(
        children: [
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),*/
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.black
                    ),
                    child: IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {},
                        color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          ListTile(
            leading: Icon(Icons.person),
            isThreeLine: true,
            title: Text(
              "Nombre",
              style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
            ),
            subtitle: Text(
              meData.fullName,
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
              style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
            ),
            subtitle: Text(
              meData.adress,
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
              style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
            ),
            subtitle: Text(
              meData.email,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            onTap: () {},
          ),
        ],
      );
    }
  }
}
