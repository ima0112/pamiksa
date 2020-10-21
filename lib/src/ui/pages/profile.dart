import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_crop/image_crop.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

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
  final NavigationService navigationService = locator<NavigationService>();
  ProfileBloc profileBloc;
  File _image;
  final picker = ImagePicker();
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });

    profileBloc.add(SendImageEvent());
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

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
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {
                          //_showPicker(context);
                          navigationService.navigateTo(Routes.PickImageRoute);
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
