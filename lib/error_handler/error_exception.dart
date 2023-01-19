
import 'package:dio/dio.dart';

class ErrorExceptions implements Exception {
  fromError(DioError dioError) {

    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return "Connection timeout with API server";
      case DioErrorType.sendTimeout:
        return "Connection timeout with API server";
      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";
      case DioErrorType.response:
        return handleError(dioError.response?.statusCode);
      case DioErrorType.cancel:
        return "Request to API server was cancelled";
      case DioErrorType.other:
        return "Connection to API server failed due to internet connection";
    }
  }

  String handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}

String handleError(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 404:
      return '404';
    case 500:
      return 'Internal server error';
    default:
      return 'Oops something went wrong';
  }
}

