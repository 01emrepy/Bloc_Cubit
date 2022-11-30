part of 'store_cubit.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {
  StoreInitial();
}

class StoreLoading extends StoreState {
  StoreLoading();
}

class Storecomplated extends StoreState {
  final List<StoreModel> model;
  Storecomplated(this.model);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storecomplated && listEquals(other.model, model);
  }

  @override
  int get hashCode => model.hashCode;
}

class StoreError extends StoreState {
  final String message;
  StoreError(this.message);
}
