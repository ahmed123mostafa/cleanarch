part of 'hive_service_impl.dart';

abstract interface class IUserCache {
  Future<void> cacheUserModel(UserModel user);
  UserModel? getCachedUserModel();
  Future<void> updateCachedUserModel(UserModel user);
  Future<void> clearUserModel();
}