import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';

import 'business_details_item_page.dart';

class BusinessPage extends StatefulWidget {
  @override
  _BusinessPagePageState createState() => _BusinessPagePageState();
}

class _BusinessPagePageState extends State<BusinessPage> {
  BusinessDetailsBloc businessDetailsBloc;
  ScrollController _scrollController;
  bool _isAppBarCollapsed = false;

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

  @override
  void initState() {
    businessDetailsBloc = BlocProvider.of<BusinessDetailsBloc>(context);
    super.initState();
    this._scrollController = ScrollController()
      ..addListener(() {
        if (isCollapsed() && !_isAppBarCollapsed) {
          setState(() {
            _isAppBarCollapsed = true;
          });
        } else if (!isCollapsed() && _isAppBarCollapsed) {
          setState(() {
            _isAppBarCollapsed = false;
          });
        }
      });
  }

  bool isCollapsed() {
    return _scrollController.hasClients &&
        _scrollController.offset > (300 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
        builder: (context, state) {
      if (state is BusinessDetailsInitial) {
        return Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else if (state is LoadingBusinessDetailsState) {
        return Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else if (state is LoadedBusinessDetailsState) {
        return Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: _isAppBarCollapsed
                  ? IconThemeData(color: Colors.black)
                  : IconThemeData(color: Colors.white),
              brightness:
                  _isAppBarCollapsed ? Brightness.light : Brightness.dark,
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            right: false,
            left: false,
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  CustomScrollView(
                    controller: this._scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.white,
                          expandedHeight: 300,
                          elevation: 0.0,
                          flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: Image.network(
                                      "${state.businessModel.photo}",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.transparent
                                                  .withOpacity(0.0),
                                              Colors.black54
                                            ],
                                            stops: [
                                              0.5,
                                              1.0
                                            ])),
                                  ),
                                ],
                              ),
                              centerTitle: false,
                              title: _isAppBarCollapsed
                                  ? Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                            state.businessModel.photo,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          state.businessModel.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                        )
                                      ],
                                    )
                                  : Text(""))),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        BusinessDetailsItemPage(
                          id: state.businessModel.id,
                        ),
                      ])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Container(
        child: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
