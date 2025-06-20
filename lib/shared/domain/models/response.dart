import 'package:countries_app/shared/domain/models/either.dart';
import 'package:countries_app/shared/exceptions/http_exception.dart';

class Response {
  Response({
    required this.statusCode,
    this.statusMessage,
    this.data = const <String, dynamic>{},
  });
  final int statusCode;
  final String? statusMessage;
  final dynamic data;
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response {
  Right<AppException, Response> get toRight => Right(this);
}
