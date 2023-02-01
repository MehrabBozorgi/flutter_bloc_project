part of 'user_bloc.dart';

class UserState extends Equatable {
  final Status status;
  final List<UserModel> userModel;
  final CustomError error;

  const UserState({
    required this.status,
    required this.userModel,
    required this.error,
  });

  factory UserState.initial() => const UserState(
        status: Status.initial,
        userModel: [],
        error: CustomError(),
      );

  @override
  List<Object> get props => [status, userModel, error];

  UserState copyWith({
    Status? status,
    List<UserModel>? userModel,
    CustomError? error,
  }) {
    return UserState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      error: error ?? this.error,
    );
  }
}
