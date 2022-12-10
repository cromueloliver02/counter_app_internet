import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../cubits/cubits.dart';
import '../../constants/constants.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  late final StreamSubscription _internetSubs;
  final InternetCubit internetCubit;

  CounterCubit({
    required this.internetCubit,
  }) : super(const CounterState(count: 0)) {
    _internetSubs = internetCubit.stream.listen(_internetListener);
  }

  @override
  Future<void> close() {
    _internetSubs.cancel();
    return super.close();
  }

  void _internetListener(InternetState internetState) {
    if (internetState is InternetConnected &&
        internetState.connectionType == ConnectionType.wifi) {
      _increment();
    }

    if (internetState is InternetConnected &&
        internetState.connectionType == ConnectionType.mobile) {
      _decrement();
    }
  }

  void _increment() => emit(CounterState(count: state.count + 1));

  void _decrement() => emit(CounterState(count: state.count - 1));
}
