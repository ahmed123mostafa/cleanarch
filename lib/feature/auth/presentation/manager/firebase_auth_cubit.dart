import 'package:cleanarch/core/bloc/paginated_bloc.dart';
import 'package:cleanarch/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseAuthCubit extends Cubit<BaseState> {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  FirebaseAuthCubit(this.firebaseAuthDataSource) : super(BaseState());
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: Status.loading));
    final result = await firebaseAuthDataSource.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(status: Status.failure, errorMessage: failure.message),
        );
      },
      (userId) {
        emit(state.copyWith(status: Status.success, data: userId));
      },
    );
  }
}
