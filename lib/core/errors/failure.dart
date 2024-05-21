import 'package:dio/dio.dart';

abstract class Failure {
  String errorMessage;
  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection Timed out with server");
      case DioExceptionType.sendTimeout:
        // TODO: Handle this case.
        break;
      case DioExceptionType.receiveTimeout:
        // TODO: Handle this case.
        break;
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request was cancelled, Please try again");
        break;
      case DioExceptionType.connectionError:
        return ServerFailure("Connection Error, Please try again");
        break;
      case DioExceptionType.unknown:
        return ServerFailure("Unexpected Error, Please try again");
    }
    return ServerFailure("There was a problem, try again later");
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure("Your request not found, Please try later");
    } else if (statusCode == 500) {
      return ServerFailure("Internal Server Error, try later!");
    } else {
      return ServerFailure("Opps There was an Error, Please try again!");
    }
  }
}
