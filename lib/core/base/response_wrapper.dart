import 'package:firebase_core/firebase_core.dart';

class ResponseWrapper<T> {
  FirebaseException? _error;
  T? _data;

  // ignore: type_annotate_public_apis, always_declare_return_types
  setException(FirebaseException error) {
    _error = error;
  }

  // ignore: use_setters_to_change_properties
  void setData(T? data) {
    _data = data;
  }

  T get getData => _data!;

  FirebaseException get getException => _error!;

  bool get hasException => _error != null;

  bool get hasData => _data != null;
}
