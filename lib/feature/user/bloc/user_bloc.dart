import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../error_handler/data_state.dart';
import '../model/user_model.dart';
import '../services/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState.initial()) {
    on<UserDataFetch>(_fetchUserEvent);
  }

  Future<void> _fetchUserEvent(
      UserDataFetch event, Emitter<UserState> emit) async {
    // emit(state.copyWith(status: Status.loading));
    // try {
    //   final List<UserModel> user = await userRepository.fetchUsers();
    //   emit(state.copyWith(status: Status.complete, userModel: user));
    // } on DioError catch (e) {
    //   print('----------------------');
    //
    //   print(ErrorExceptions().fromError(e));
    //   emit(state.copyWith(
    //       status: Status.error,
    //       error: CustomError(errMsg: ErrorExceptions().fromError(e))));
    // }
    emit(state.copyWith(newUserDataStatus: UserDataLoading()));

    DataState dataState = await userRepository.fetchUsers();

    if (dataState is DataSuccess) {
      /// emit completed
      emit(
          state.copyWith(newUserDataStatus: UserDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {

      /// emit error
      emit(state.copyWith(newUserDataStatus: UserDataError(dataState.error!)));
    }
  }
}
