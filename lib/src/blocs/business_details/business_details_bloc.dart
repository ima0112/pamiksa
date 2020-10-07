import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';

part 'business_details_event.dart';
part 'business_details_state.dart';

class BusinessDetailsBloc
    extends Bloc<BusinessDetailsEvent, BusinessDetailsState> {
  final BusinessRepository businessRepository;

  BusinessDetailsBloc(this.businessRepository)
      : super(BusinessDetailsInitial());

  @override
  Stream<BusinessDetailsState> mapEventToState(
    BusinessDetailsEvent event,
  ) async* {
    if (event is FetchBusinessDetails) {
      yield* _mapFetchBusinessDetails(event);
    }
  }

  Stream<BusinessDetailsState> _mapFetchBusinessDetails(
      FetchBusinessDetails event) async* {
    yield LoadingBusinessDetailsState();

    BusinessModel businessResult = await businessRepository.getById(event.id);

    yield LoadedBusinessDetailsState(businessResult);
  }
}
