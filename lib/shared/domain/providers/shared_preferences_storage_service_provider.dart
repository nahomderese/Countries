import 'package:countries_app/shared/data/local/shared_prefs_storage_service.dart';
import 'package:countries_app/shared/domain/providers/log_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPrefstorageServiceProvider = Provider((ref) {
  final logger = ref.watch(logProvider);
  return SharedPrefsService(logger)..init();
}, name: 'sharedPrefstorageServiceProvider');
