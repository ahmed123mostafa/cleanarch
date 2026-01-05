import 'package:cleanarch/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:cleanarch/feature/auth/presentation/manager/firebase_auth_cubit.dart';
import 'package:cleanarch/feature/auth/presentation/manager/firebase_register_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuth {
  static Future<void> init({required GetIt getIt}) async {
    // سجل FirebaseAuth نفسه
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // سجل الـ DataSource
    getIt.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(getIt<FirebaseAuth>()),
    );

    // سجل Cubit
    getIt.registerFactory<FirebaseAuthCubit>(
      () => FirebaseAuthCubit(getIt<FirebaseAuthDataSource>()),
    );
    getIt.registerFactory<FirebaseRegisterCubit>(
  () => FirebaseRegisterCubit(getIt<FirebaseAuthDataSource>()),
);
  }
  
}

