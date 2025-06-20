import 'package:countries_app/configs/app_configs.dart';
import 'package:countries_app/shared/data/remote/network_service.dart';
import 'package:countries_app/shared/domain/models/either.dart';
import 'package:countries_app/shared/domain/models/response.dart' as response;
import 'package:countries_app/shared/exceptions/http_exception.dart';
import 'package:countries_app/shared/globals.dart';
import 'package:countries_app/shared/mixins/exception_handler_mixin.dart';
import 'package:countries_app/shared/utils/device_info.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:logger/logger.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  DioNetworkService({required this.dio, required this.logger}) {
    dio.options = dioBaseOptions;

    dio.interceptors.addAll([
      HttpFormatter(
        loggingFilter: (request, response, error) => true,
        logger: logger,
        includeResponseHeaders: false,
      ),
    ]);

    getDeviceInfo().then(
      (deviceInfo) => dio.options.headers.addAll({'device-info': deviceInfo}),
    );
  }
  final Dio dio;
  final Logger logger;

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );
  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, Object> get headers => {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  DioNetworkService updateHeader(Map<String, String> newHeaders) {
    if (!kTestMode) {
      dio.options.headers = headers..addAll(newHeaders);
    }
    return this;
  }

  @override
  DioNetworkService clearHeader() {
    dio.options.headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
    };
    return this;
  }

  @override
  Future<Either<AppException, response.Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.post(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    final res = handleException(
      () => dio.get(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.delete(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> patch(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.patch(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.put(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }
}
