part of 'check_connection_bloc.dart';

@immutable
abstract class CheckConnectionState extends Equatable {
  const CheckConnectionState();
}

class CheckConnectionInitial extends CheckConnectionState {
  @override
  List<Object> get props => [];
}

class ConnectedState extends CheckConnectionState {
  final String message;

  const ConnectedState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class NotConnectedState extends CheckConnectionState {
  final String message;

  const NotConnectedState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
