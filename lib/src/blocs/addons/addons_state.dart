part of 'addons_bloc.dart';

abstract class AddonsState extends Equatable {
  const AddonsState();

  @override
  List<Object> get props => [];
}

class AddonsInitial extends AddonsState {}

class LoadingAddonssState extends AddonsState {}

class LoadedAddonsState extends AddonsState {
  final int count;
  // final FoodModel foodModel;
  final List<AddonsModel> addonsModel;

  LoadedAddonsState({this.addonsModel, this.count});
}
