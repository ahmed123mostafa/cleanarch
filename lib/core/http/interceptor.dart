import 'package:cleanarch/core/helpers/logger.dart';
import 'package:cleanarch/core/local/hive_service_impl.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  const LoggerInterceptor();
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    loggerFatal(response.statusCode);
    loggerWarn(response.data);
    handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer ${HiveServiceImpl.instance.getAccessToken()}';
    loggerVerbose("ONREQUEST ${options.uri} ${handler.isCompleted}");
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    loggerError(err.response.toString());

    handler.next(err);
  }
}