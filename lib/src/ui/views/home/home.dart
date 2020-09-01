import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/home_bloc.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/views/home/business_item.dart';
import 'package:path/path.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        // title: Text(
        //   "Pamiksa",
        //   style: TextStyle(color: Theme.of(context).primaryColor),
        // ),
      ),
      body: Builder(
        builder: (context) => BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is BusinessOptionsPulsedState) {}
            return ListView(
                children: listBusiness
                    .map((e) => BusinessItem(
                          name: e.name,
                          photo: e.photo,
                          adress: e.adress,
                          valoration: e.valoration,
                          deliveryPrice: e.deliveryPrice,
                        ))
                    .toList());
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
