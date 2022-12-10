import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../constants/constants.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late final StreamSubscription _connectivitySubs;
  final Connectivity connectivity;

  InternetCubit({
    required this.connectivity,
  }) : super(InternetInitial()) {
    _connectivitySubs =
        connectivity.onConnectivityChanged.listen(_connectivityListener);
  }

  @override
  Future<void> close() {
    _connectivitySubs.cancel();
    return super.close();
  }

  void _connectivityListener(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      internetConnected(ConnectionType.wifi);
    }

    if (connectivityResult == ConnectivityResult.mobile) {
      internetConnected(ConnectionType.mobile);
    }

    if (connectivityResult == ConnectivityResult.none) {
      internetDisconnected();
    }
  }

  void internetConnected(ConnectionType connectionType) {
    emit(InternetConnected(connectionType: connectionType));
  }

  void internetDisconnected() {
    emit(InternetDisconnected());
  }
}
