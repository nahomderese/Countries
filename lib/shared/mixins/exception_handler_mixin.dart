import 'dart:async';
import 'dart:io';

import 'package:countries_app/shared/data/remote/remote.dart';
import 'package:countries_app/shared/domain/models/either.dart';
import 'package:countries_app/shared/domain/models/response.dart' as response;
import 'package:countries_app/shared/exceptions/http_exception.dart';
import 'package:dio/dio.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.Response>>
  handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      final res = await handler();
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } on SocketException catch (e) {
      return Left(
        AppException(
          message: 'Unable to connect to the server.',
          statusCode: 0,
          identifier: 'Socket Exception ${e.message}\n at  $endpoint',
        ),
      );
    } on DioException catch (_) {
      rethrow;
    } on Exception catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 2,
          identifier: 'Unknown error $e\n at $endpoint',
        ),
      );
    }
  }
}
