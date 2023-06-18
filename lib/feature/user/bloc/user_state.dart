part of 'user_bloc.dart';

class UserState {
  UserEvent userDataEvent;

  UserState({required this.userDataEvent});

  UserState copyWith({UserEvent? newUserDataStatus}) {
    return UserState(userDataEvent: newUserDataStatus ?? userDataEvent);
  }

  factory UserState.initial() => UserState(userDataEvent: UserDataInitial());
}
