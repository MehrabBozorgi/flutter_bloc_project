import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'check_connection_event.dart';
part 'check_connection_state.dart';

class CheckConnectionBloc
    extends Bloc<CheckConnectionEvent, CheckConnectionState> {
  StreamSubscription? _subscription;

  CheckConnectionBloc() : super(CheckConnectionInitial()) {
    on<CheckConnectionEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(const ConnectedState(message: "Connected"));
      } else if (event is NotConnectedEvent) {
        emit(const NotConnectedState(message: "Not Connected"));
      }
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi &&
              result == ConnectivityResult.mobile) {
        add(ConnectedEvent());
      } else {
        add(NotConnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
