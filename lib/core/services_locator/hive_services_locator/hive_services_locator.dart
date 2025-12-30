import 'package:cleanarch/core/local/hive_service_impl.dart';
import 'package:get_it/get_it.dart';


class HiveServiceLocator {
  static Future<void> init({required GetIt getIt}) async {
    getIt.registerLazySingleton<HiveServiceImpl>(
      () => HiveServiceImpl.instance,
    );
    getIt.registerLazySingleton<IUserCache>(() => HiveServiceImpl.instance);
   getIt.registerLazySingleton<ITokenCache>(() => HiveServiceImpl.instance);
    // getIt.registerLazySingleton<IProfileCache>(() => HiveServiceImpl.instance);
    // getIt.registerLazySingleton<IPaginatedCache<GetProductByCatagoryModel>>(
    //   () => GetCatoryItemsPaginatedCache(getIt<HiveServiceImpl>()),
    // );
    // getIt.registerLazySingleton<IPaginatedCache<GetActiveSupplierProduct>>(
    //   () => GetactivesupplierPaginatedCache(getIt<HiveServiceImpl>()),
    // );
  }
}
