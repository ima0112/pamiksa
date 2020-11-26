import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/widgets/widgets.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key key}) : super(key: key);

  @override
  _BusinessPagePageState createState() => _BusinessPagePageState();
}

class _BusinessPagePageState extends State<BusinessPage> {
  final NavigationService navigationService = locator<NavigationService>();

  BusinessDetailsBloc businessDetailsBloc;
  FoodBloc foodBloc;

  ScrollController _scrollController;
  ScrollController _scrollControllerList;

  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    foodBloc = BlocProvider.of<FoodBloc>(context);
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
        return BusinessSkeletonPage();
      } else if (state is LoadingBusinessDetailsState) {
        return BusinessSkeletonPage();
      } else if (state is BusinessTokenExpired) {
        businessDetailsBloc.add(BusinessRefreshTokenEvent());
        return BusinessSkeletonPage();
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
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage(
                        width: 500,
                        fit: BoxFit.cover,
                        height: 225,
                        placeholder: AssetImage("assets/gif/loading.gif"),
                        image: NetworkImage(state.businessModel.photoUrl),
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
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 20),
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
                          vertical: 20.0, horizontal: 15.0),
                      title: Text(
                        state.foodModel[index].name,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onTap: () {
                        foodBloc.add(FetchFoodEvent(state.foodModel[index].id));
                        navigationService.navigateTo(Routes.FoodRoute);
                      },
                      subtitle: Text(
                        "\$ ${state.foodModel[index].price}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Hero(
                        tag: state.foodModel[index].photo,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: FadeInImage(
                            fit: BoxFit.fitWidth,
                            width: 80,
                            image: NetworkImage(
                              state.foodModel[index].photoUrl,
                            ),
                            placeholder: AssetImage("assets/gif/loading.gif"),
                          ),
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
      return Scaffold(
          body: Center(
              child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    businessDetailsBloc.add(SetInitialBusinessDetailsEvent());
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Reintentar"))));
    });
  }
}
