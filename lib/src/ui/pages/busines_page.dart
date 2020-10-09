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

  @override
  void initState() {
    businessDetailsBloc = BlocProvider.of<BusinessDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

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
          return Scaffold(
            body: SafeArea(
              bottom: true,
              top: false,
              right: false,
              left: false,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      snap: true,
                      pinned: true,
                      forceElevated: true,
                      floating: true,
                      elevation: 2.0,
                      expandedHeight: 200.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          "${state.businessModel.photo}",
                          fit: BoxFit.fill,
                        ),
                        centerTitle: false,
                        title: Text(
                          "${state.businessModel.name}",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      )),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (_, index) => Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[200],
                          child: BusinessItemSkeletonPage()),
                      separatorBuilder: (_, __) => Divider(height: 0.0),
                    )
                  ]))
                ],
              ),
            ),
          );
        }
        return Scaffold(
            body: Center(
          child: Text("details"),
        ));
      },
    );
  }
}
