import 'package:dio/dio.dart';

import '../../../cosntance/domain.dart';
import '../../../error_handler/check_exceptions.dart';

class UserApiService {
  //time by millisecond
  final Dio _dio = Dio();

  Future<dynamic> callUserApi() async {
    final uri = Uri(
      scheme: 'https',
      host: userDomain,
      path: '/publickjgvc/v2/users',
    );

    //connect to server time out
    _dio.options.connectTimeout = 20000;
    //send params to server time out
    _dio.options.receiveTimeout = 15000;
    //response from server time out
    _dio.options.sendTimeout = 15000;
    //

    final Response response =
        await _dio.getUri(uri).onError((DioError error, stackTrace) {
      return CheckExceptions.response(error.response!);
    });
    print(response.data);
    return response;
  }
}
