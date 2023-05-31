import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection Timeout with API Server');

      case DioErrorType.sendTimeout:
        return ServerFailure('Send Timeout with API Server');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Recive Timeout with API Server');
      case DioErrorType.badCertificate:
        return ServerFailure('BadCertificate with API Server');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode, e.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request  with API Server was canceled');
      case DioErrorType.connectionError:
        return ServerFailure('Connection Internet Error with API Server');
      case DioErrorType.unknown:
        return ServerFailure('Please Try Again!');
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your Request Not Found');
    } else if (statusCode == 500) {
      return ServerFailure('Ther is a problem with Server');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure('Ther Was A problem');
    }
  }
}
