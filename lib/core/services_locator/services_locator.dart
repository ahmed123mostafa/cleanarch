import 'package:cleanarch/core/data_source/generic_data_source.dart';
import 'package:cleanarch/core/helpers/connectivity_services.dart';
import 'package:cleanarch/core/helpers/logger.dart';
import 'package:cleanarch/core/helpers/sync_manager.dart';
import 'package:cleanarch/core/http/api_concumer.dart';
import 'package:cleanarch/core/http/end_point.dart';
import 'package:cleanarch/core/local/hive_service_impl.dart';
import 'package:cleanarch/core/services_locator/firebase_auth/fire_base_auth.dart';
import 'package:cleanarch/core/services_locator/hive_services_locator/hive_services_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt getIt = GetIt.instance;

abstract interface class DI {
  static Future<void> init() async {
    final token = HiveServiceImpl.instance.getAccessToken() ?? "";
    loggerWarn("TOKEN $token");
    getIt.registerLazySingleton<Dio>(() {
      return Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            connectTimeout: const Duration(seconds: 60),
            headers: {
              'Accept': 'application/json',
              // 'Accept-Language':
              // navigatorKey.currentContext?.isArabic??true ? 'ar' : 'en',
              'Authorization': 'Bearer $token',
            },
          ),
        )
        ..interceptors.addAll([
          if (kDebugMode)
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              enabled: true,
              request: true,
              maxWidth: 90,
            ),
          // LoggerInterceptor(),
        ]);
    });
    await HiveServiceLocator.init(getIt: getIt);

    getIt.registerLazySingleton<ApiConsumer>(
      () => BaseApiConsumer(dio: getIt<Dio>()),
    );
    getIt.registerLazySingleton<GenericDataSource>(
      () => GenericDataSource(getIt<ApiConsumer>()),
    );
    getIt.registerLazySingleton<SyncManager>(() => SyncManager());
    getIt.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService.instance,
    );
   // await AuthServicesLocator.init(getIt: getIt);
   await FireBaseAuth.init(getIt: getIt);
   
  }
}