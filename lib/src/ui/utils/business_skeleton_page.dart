import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/pages/food_item_skeleton_page.dart';
import 'package:shimmer/shimmer.dart';

class BusinessSkeletonPage extends StatefulWidget {
  @override
  _BusinessSkeletonPageState createState() => _BusinessSkeletonPageState();
}

class _BusinessSkeletonPageState extends State<BusinessSkeletonPage> {
  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cargando...',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LinearProgressIndicator(),
              Shimmer.fromColors(
                baseColor: Theme.of(context).chipTheme.disabledColor,
                highlightColor: Theme.of(context).chipTheme.backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 225,
                            color: Theme.of(context).chipTheme.backgroundColor,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 1.5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 180,
                              height: 10,
                              color:
                                  Theme.of(context).chipTheme.backgroundColor,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 2.5, 0, 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Container(
                                  width: 220,
                                  height: 10,
                                  color: Theme.of(context)
                                      .chipTheme
                                      .backgroundColor,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 2.5, 0, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 260,
                              height: 10,
                              color:
                                  Theme.of(context).chipTheme.backgroundColor,
                            ),
                          )),
                      Divider(
                        height: 0.0,
                      ),
                      ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (_, index) => Shimmer.fromColors(
                          baseColor: Theme.of(context).chipTheme.disabledColor,
                          highlightColor:
                              Theme.of(context).chipTheme.backgroundColor,
                          child: FoodItemSkeletonPage(),
                        ),
                        separatorBuilder: (_, __) => Divider(height: 0.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
