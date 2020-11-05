import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class BusinessPage extends StatefulWidget {
  final String id;

  const BusinessPage({Key key, this.id}) : super(key: key);

  @override
  _BusinessPagePageState createState() => _BusinessPagePageState();
}

class _BusinessPagePageState extends State<BusinessPage> {
  final NavigationService navigationService = locator<NavigationService>();

  BusinessDetailsBloc businessDetailsBloc;
  AddonsBloc addonsBloc;

  ScrollController _scrollController;
  ScrollController _scrollControllerList = ScrollController();
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    addonsBloc = BlocProvider.of<AddonsBloc>(context);
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
        businessDetailsBloc.add(FetchBusinessDetailsEvent(state.id));
        return Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else if (state is LoadedBusinessDetailsState) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                state.businessModel.name,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        state.businessModel.photo,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 1.5),
                    child: Text(
                      state.businessModel.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.businessModel.adress),
                          Icon(
                            Icons.location_on,
                            size: 16.0,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 27.5),
                    child: Text(state.businessModel.description),
                  ),
                  Divider(
                    height: 0.0,
                  ),
                  ListView.separated(
                    controller: _scrollControllerList,
                    shrinkWrap: true,
                    itemCount: state.foodModel.length,
                    itemBuilder: (_, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      title: Text(
                        state.foodModel[index].name,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onTap: () {
                        addonsBloc
                            .add(FetchAddonsEvent(state.foodModel[index].id));
                        navigationService.navigateTo(Routes.FoodRoute);
                      },
                      subtitle: Text("Precio: ${state.foodModel[index].price}"),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Image.network(
                          state.foodModel[index].photo,
                          fit: BoxFit.fitHeight,
                          height: 100,
                        ),
                      ),
                      dense: true,
                    ),
                    separatorBuilder: (_, __) => Divider(height: 0.0),
                  )
                ],
              ),
            ));
      }
      return Container(
        child: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
