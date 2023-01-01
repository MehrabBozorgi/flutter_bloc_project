import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api_bloc/error_handler/custom_error.dart';
import 'package:flutter_call_api_bloc/error_handler/error_exception.dart';
import 'package:flutter_call_api_bloc/user/model/user_model.dart';

import '../../cosntance/enum.dart';
import '../services/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState.initial()) {
    on<FetchUserEvent>(_fetchUserEvent);
  }

  Future<void> _fetchUserEvent(
      FetchUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<UserModel> user = await userRepository.fetchUsers();
      emit(state.copyWith(status: Status.complete, userModel: user));
    } on DioError catch (e) {
      print('----------------------');

      print(ErrorExceptions().fromError(e));
      emit(state.copyWith(
          status: Status.error,
          error: CustomError(errMsg: ErrorExceptions().fromError(e))));
    }
  }
}
