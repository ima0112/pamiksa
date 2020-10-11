import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';

class BusinessDetailsItemPage extends StatefulWidget {
  String id;

  BusinessDetailsItemPage({this.id});

  @override
  _BusinessDetailsItemPageState createState() =>
      _BusinessDetailsItemPageState();
}

class _BusinessDetailsItemPageState extends State<BusinessDetailsItemPage> {
  final ScrollController _scrollController = ScrollController();

  FoodsBloc foodsBloc;

  @override
  void initState() {
    foodsBloc = BlocProvider.of<FoodsBloc>(context);
    foodsBloc.add(FetchFoodsEvent(this.widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      builder: (context, state) {
        if (state is LoadingFoodsState) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is LoadedFoodsState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.count,
                  itemBuilder: (_, index) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    title: Text("${state.foodModel[index].name}"),
                    subtitle: Text("Precio: ${state.foodModel[index].price}"),
                    trailing: Image.asset("assets/images/profile.png"),
                    dense: true,
                  ),
                  separatorBuilder: (_, __) => Divider(
                    height: 20.0,
                  ),
                ),
              ),
            ],
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
