
import 'package:cleanarch/feature/auth/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'token_cash_interface.dart';
part 'user_cash_interface.dart';
part 'paginated_cash_interface.dart';
class HiveServiceImpl implements IUserCache, ITokenCache {
  static const String userBoxName = 'user_box';
  static const String tokenBoxName = 'token_box';
  static Box<UserModel>? _userBox;
  static Box<String>? _tokenBox;
  static const String currentUserKey = 'current_user';
  static const String accessTokenKey = 'access_token';
 // static const String _profileBoxName = 'profile';
  //static Box<GetMyProfileModel>? _profileKey;

  HiveServiceImpl._();

  static final HiveServiceImpl instance = HiveServiceImpl._();

  static Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(UserModelAdapter());
    // Hive.registerAdapter(GetProductByCatagoryModelAdapter());
    // Hive.registerAdapter(GetActiveSupplierProductAdapter());
    // Hive.registerAdapter(OrderModelAdapter());
    // Hive.registerAdapter(OrderItemAdapter());
    // Hive.registerAdapter(GetMyProfileModelAdapter());
    // Hive.registerAdapter(GetSupplierPenalitiesModelAdapter());
    // Hive.registerAdapter(GetSupplierstatmentModelAdapter());
    // Hive.registerAdapter(ReturnedItemsModelAdapter());
    // Hive.registerAdapter(StationsModelAdapter());
    // Hive.registerAdapter(GetMyDeliveryStationModelAdapter());
    // Hive.registerAdapter(SupplierRatingsModelAdapter());
    // Hive.registerAdapter(RatingAllModelAdapter());
    // Hive.registerAdapter(ReturnedOrderModelAdapter());

    _userBox = await Hive.openBox<UserModel>(userBoxName);
    _tokenBox = await Hive.openBox<String>(tokenBoxName);
    //  _profileKey = await Hive.openBox<GetMyProfileModel>(_profileBoxName);
  }

  @override
  Future<void> cacheUserModel(UserModel user) async {
    await _userBox?.put(currentUserKey, user);
  }

  @override
  UserModel? getCachedUserModel() {
    final user = _userBox?.get(currentUserKey);
    if (user != null) {}
    return user;
  }

  @override
  Future<void> updateCachedUserModel(UserModel user) async {
    final currentUser = _userBox?.get(currentUserKey);

    if (currentUser == null) {
      await _userBox?.put(currentUserKey, user);
      return;
    }

    UserModel updatedUser;
    updatedUser = currentUser;
    await _userBox?.put(currentUserKey, updatedUser);

    // Debug log
    //logger('Updated user in cache: ${updatedUser.toJson()}');
  }

  @override
  Future<void> clearUserModel() async {
    await _userBox?.delete(currentUserKey);
  }

  // ---------------------- Token ----------------------
  @override
  Future<void> saveAccessToken(String token) async {
    await _tokenBox?.put(accessTokenKey, token);
  }

  @override
  String? getAccessToken() {
    return _tokenBox?.get(accessTokenKey);
  }

  @override
  Future<void> clearAccessToken() async {
    await _tokenBox?.delete(accessTokenKey);
  }

  // ------------------- Paginated Cache ---------------------
  Future<void> _cachePage<T>(List<T> items, {required String cacheKey}) async {
    final box = await Hive.openBox<T>(cacheKey);
    await box.putAll(items.asMap());
  }

  // Generic retrieval method
  Future<List<T>> _getCachedPage<T>({required String cacheKey}) async {
    final box = await Hive.openBox<T>(cacheKey);
    return box.values.toList();
  }

  // Generic clear method
  Future<void> _clearCachedPage<T>({required String cacheKey}) async {
    final box = await Hive.openBox<T>(cacheKey);
    await box.clear();
  }

  //////////  cach   profile
}
