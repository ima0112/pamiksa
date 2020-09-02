/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/home_bloc.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/views/home/business_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Business> listBusiness = [
      Business(
          id: "1",
          name: "Don",
          adress: "Avenida 9na #706 entre Cristina y Minervaaaaaaaaaa",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Lo mas sabroso de la comida cubana a tu alcanse",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 4.5,
          deliveryPrice: 25.7,
          photo: "carne_hamburguesa1.jpg",
          provinceFk: "1"),
      Business(
          id: "2",
          name: "Hamburguesera Pepitos",
          adress: "Cespedes #7 entre Cristina y Minerva",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Quieres Hamburguesas, pues echa pa k.",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 3.7,
          deliveryPrice: 25.7,
          photo: "hamburguesa.jpg",
          provinceFk: "1"),
      Business(
          id: "3",
          name: "TuHotDog",
          adress: "Cristina #6 entre Aiyon y Cespedes",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Los mejores HotDogs de Cardenas.",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 4.8,
          deliveryPrice: 25.7,
          photo: "hotdogs.jpg",
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
    ];
    return Scaffold(
      body: Builder(
        builder: (context) => BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is BusinessOptionsPulsedState) {}
            return ListView.separated(
              itemBuilder: (_, index) => BusinessItem(
                name: listBusiness[index].name,
                photo: listBusiness[index].photo,
                adress: listBusiness[index].adress,
                valoration: listBusiness[index].valoration,
                deliveryPrice: listBusiness[index].deliveryPrice,
              ),
              itemCount: listBusiness.length,
              separatorBuilder: (_, __) => Divider(height: 0.0),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Cuenta")),
        ],
      ),
    );
  }
}

class BottomSheetMy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(color: Colors.red));
      },
    );
  }
}
*/

import 'package:flutter/cupertino.dart';

/// Arriba esta el codigo de la vista original...

import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/views/home/business_item.dart';

class Home extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Business> listBusiness = [
      Business(
          id: "1",
          name: "Don",
          adress: "Avenida 9na #706 entre Cristina y Minervaaaaaaaaaa",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Lo mas sabroso de la comida cubana a tu alcanse",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 4.5,
          deliveryPrice: 25.7,
          photo: "carne_hamburguesa1.jpg",
          provinceFk: "1"),
      Business(
          id: "2",
          name: "Hamburguesera Pepitos",
          adress: "Cespedes #7 entre Cristina y Minerva",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Quieres Hamburguesas, pues echa pa k.",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 3.7,
          deliveryPrice: 25.7,
          photo: "hamburguesa.jpg",
          provinceFk: "1"),
      Business(
          id: "3",
          name: "TuHotDog",
          adress: "Cristina #6 entre Aiyon y Cespedes",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description: "Los mejores HotDogs de Cardenas.",
          email: "don@gmail.com",
          phone: "45567800",
          valoration: 4.8,
          deliveryPrice: 25.7,
          photo: "hotdogs.jpg",
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
      Business(
          id: "4",
          name: "DinoPizzas",
          adress: "Saez #100 entre Cristina y Velasquez",
          businessOwnerFk: "1",
          municipalityFk: "1",
          description:
              "De todos los tamannos y todos los sabores la pizza que tu quieres esta aki.",
          email: "don@gmail.com",
          deliveryPrice: 25.7,
          phone: "45567800",
          photo: "pizza.jpg",
          valoration: 2.8,
          provinceFk: "1"),
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
          )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 1.0,
              title: Text(
                "Pamiksa",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // actions: <Widget>[
              //   IconButton(icon: Icon(Icons.apps), onPressed: () {}),
              // ],
              expandedHeight: 2 * kToolbarHeight,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Chip(
                            avatar: Icon(Icons.filter_list),
                            label: Text("Filtrar")),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("Para Recojer"),
                          avatar: Icon(Icons.store),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("A Domicilio"),
                          avatar: Icon(Icons.directions_bike),
                        )
                      ],
                    )),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: listBusiness.length,
                itemBuilder: (_, index) => BusinessItem(
                  name: listBusiness[index].name,
                  photo: listBusiness[index].photo,
                  adress: listBusiness[index].adress,
                  valoration: listBusiness[index].valoration,
                  deliveryPrice: listBusiness[index].deliveryPrice,
                ),
                separatorBuilder: (_, __) => Divider(height: 0.0),
              )
            ]))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Cuenta")),
        ],
      ),
    );
  }
}
