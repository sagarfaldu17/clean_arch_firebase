import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure({this.message, this.code});

  final String? message;
  final int? code;
}

String getFailureMessage(Failure failure) {
  if (failure is ServerFailure) {
    return failure.message ?? "";
  } else {
    return "";
  }
}
