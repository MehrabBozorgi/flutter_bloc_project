part of 'check_connection_bloc.dart';

abstract class CheckConnectionEvent extends Equatable {
  const CheckConnectionEvent();
}

class ConnectedEvent extends CheckConnectionEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NotConnectedEvent extends CheckConnectionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}