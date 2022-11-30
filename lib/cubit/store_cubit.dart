import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../model/model.dart';
import '../repo.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository _storeRepository;
  StoreCubit(this._storeRepository) : super(StoreInitial());

  Future<void> getStore() async {
    try {
      emit(StoreLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      List<StoreModel> getStore = await _storeRepository.getStore();
      emit(Storecomplated(getStore));
    } on NetworkError catch (e) {
      emit(StoreError(e.message));
    }
  }
}
