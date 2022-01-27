import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;
  DioExceptions.fromDioError(DioError dioError) {
    message = _handleError(
        dioError.response!.statusCode ?? 0, dioError.response!.data);
  }

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
