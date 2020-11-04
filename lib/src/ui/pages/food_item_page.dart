import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class AddonsItemPage extends StatefulWidget {
  @override
  _AddonsItemPageState createState() => _AddonsItemPageState();
}

class _AddonsItemPageState extends State<AddonsItemPage> {
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();

  AddonsBloc addonsBloc;

  @override
  void initState() {
    addonsBloc = BlocProvider.of<AddonsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddonsBloc, AddonsState>(
      builder: (context, state) {
        if (state is LoadingAddonssState) {
          return Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
          );
        } else if (state is LoadedAddonsState) {
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
                    title: Text("${state.addonsModel[index].name}"),
                    subtitle: Text("Precio: ${state.addonsModel[index].price}"),
                    trailing: Container(
                      height: 50,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {},
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                          Text("0"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ),
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
        return null;
      },
    );
  }
}
