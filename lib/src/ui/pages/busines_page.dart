import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/graphql/queries/business.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class BusinessPage extends StatefulWidget {
  @override
  _BusinessPagePageState createState() => _BusinessPagePageState();
}

class _BusinessPagePageState extends State<BusinessPage> {
  BusinessDetailsBloc businessDetailsBloc;

  List<String> options = ["Filtrar", "Informacion"];

  @override
  void initState() {
    businessDetailsBloc = BlocProvider.of<BusinessDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          right: false,
          left: false,
          child: businessDetails()),
    );
  }

  Widget businessDetails() {
    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
        builder: (context, state) {
      if (state is LoadingBusinessDetailsState) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is LoadedBusinessDetailsState) {
        return CustomScrollView(
          slivers: <Widget>[sliverApp(), sliverInfo(), sliverFoodsList()],
        );
      }
    });
  }

  Widget sliverApp() {
    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
      builder: (context, state) {
        if (state is LoadedBusinessDetailsState) {
          return SliverAppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      modalButtonSheet();
                    })
              ],
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 2.0,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Image.network(
                        "${state.businessModel.photo}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.transparent.withOpacity(0.0),
                                Colors.white70
                              ],
                              stops: [
                                0.5,
                                1.0
                              ])),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent.withOpacity(0.0),
                                Colors.white70
                              ],
                              stops: [
                                0.5,
                                1.0
                              ])),
                    ),
                  ],
                ),
                centerTitle: true,
                title: Text(
                  "${state.businessModel.name}",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ));
        }
      },
    );
  }

  modalButtonSheet() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        builder: (context) => Container(
              height: 200,
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
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${options[index]}"),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 0.0,
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget sliverInfo() {
    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
      builder: (context, state) {
        if (state is LoadedBusinessDetailsState) {
          return SliverList(
              delegate: SliverChildListDelegate([
            Divider(
              height: 10.0,
              thickness: 5.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  dense: true,
                  title: Text("${state.businessModel.description}"),
                  subtitle:
                      Text("Precio: ${state.businessModel.deliveryPrice}"),
                ),
                Divider(
                  height: 10.0,
                  thickness: 5.0,
                ),
              ],
            ),
          ]));
        }
      },
    );
  }

  Widget sliverFoodsList() {
    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
      builder: (context, state) {
        if (state is LoadedBusinessDetailsState) {
          return SliverList(
              delegate: SliverChildListDelegate([
            BusinessDetailsItemPage(
              id: state.businessModel.id,
            ),
          ]));
        }
      },
    );
  }
}
