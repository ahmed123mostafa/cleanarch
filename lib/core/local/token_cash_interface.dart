part of 'hive_service_impl.dart';

abstract interface class ITokenCache {
  String? getAccessToken();
  Future<void> saveAccessToken(String token);
  void clearAccessToken();
}