part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserDataFetch extends UserEvent {}

class UserDataInitial extends UserEvent {}

class UserDataLoading extends UserEvent {}

class UserDataCompleted extends UserEvent {
  final List<UserModel> userModel;

  UserDataCompleted(this.userModel);
}

class UserDataError extends UserEvent {
  final String errorMessage;

  UserDataError(this.errorMessage);
}
