import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/pages/food_item_skeleton_page.dart';
import 'package:shimmer/shimmer.dart';

class FoodListSkeleton extends StatefulWidget {
  @override
  _FoodListSkeletonState createState() => _FoodListSkeletonState();
}

class _FoodListSkeletonState extends State<FoodListSkeleton> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LinearProgressIndicator(),
          ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (_, index) => Shimmer.fromColors(
              baseColor: Theme.of(context).chipTheme.disabledColor,
              highlightColor: Theme.of(context).chipTheme.backgroundColor,
              child: FoodItemSkeletonPage(),
            ),
            separatorBuilder: (_, __) => Divider(height: 0.0),
          )
        ],
      ),
    );
  }
}
