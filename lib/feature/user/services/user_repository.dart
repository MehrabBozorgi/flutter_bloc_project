import 'package:dio/dio.dart';
import 'package:flutter_call_api_bloc/error_handler/data_state.dart';
import 'package:flutter_call_api_bloc/feature/user/services/user_api_service.dart';

import '../../../error_handler/app_exception.dart';
import '../../../error_handler/check_exceptions.dart';
import '../model/user_model.dart';

class UserRepository {
  UserApiService userApiService = UserApiService();

  Future<DataState<List<UserModel>>> fetchUsers() async {
    List<UserModel> loaded = [];

    try {
      Response response = await userApiService.callUserApi();
      print(response.data.length);
      for (int i = 0; i < response.data.length; i++) {
        final result = UserModel.fromJson(response.data[i]);

        loaded.add(result);

      }
      return DataSuccess(loaded);
    } on AppException catch (e) {

      return await CheckExceptions.getError(e);
    }
  }
}
