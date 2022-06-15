import 'package:sqflite_example/core/base/response_wrapper.dart';

class ServerError implements Exception {
  static ResponseWrapper<T> firebaseExceptionHandle<T>(dynamic error) {
    var responseWrapper = ResponseWrapper<T>();
    responseWrapper.setException(error);
    return responseWrapper;
  }
}
