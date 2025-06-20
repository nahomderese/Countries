import 'package:countries_app/shared/data/remote/dio_network_service.dart';
import 'package:countries_app/shared/domain/providers/log_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioNetworkServiceNotifier extends StateNotifier<DioNetworkService> {
  DioNetworkServiceNotifier(super.service);

  void updateHeaders(Map<String, String> newHeaders) =>
      state = state.updateHeader(newHeaders);

  void clearHeaders() => state = state.clearHeader();
}

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final networkServiceProvider =
    StateNotifierProvider<DioNetworkServiceNotifier, DioNetworkService>((ref) {
      final Dio dio = ref.watch(dioProvider);

      final logger = ref.watch(logProvider);

      return DioNetworkServiceNotifier(
        DioNetworkService(dio: dio, logger: logger),
      );
    }, name: 'networkServiceProvider');
