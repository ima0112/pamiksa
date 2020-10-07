import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/graphql/queries/business.dart';
import 'package:pamiksa/src/data/models/models.dart';

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
            appBar: AppBar(
              elevation: 2.0,
              title: Text(
                "${state.businessModel.name}",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
            ),
          );
        }
      },
    );
  }
}
