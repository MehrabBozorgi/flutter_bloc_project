import 'package:dio/dio.dart';
import 'package:flutter_call_api_bloc/feature/user/services/user_api_service.dart';

import '../model/user_model.dart';

class UserRepository {
  UserApiService userApiService = UserApiService();

  Future<List<UserModel>> fetchUsers() async {
    Response response = await userApiService.callUserApi();

    List<UserModel> loaded = [];

    if (response.statusCode == 200) {
      List data = response.data;
      for (int i = 0; i < data.length; i++) {
        final result = UserModel.fromJson(data[i]);
        loaded.add(result);
      }
    }

    return loaded;
  }
}
