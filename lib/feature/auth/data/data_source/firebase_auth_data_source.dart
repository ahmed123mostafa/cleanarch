import 'package:cleanarch/core/failuire/failuire.dart';
import 'package:cleanarch/core/http/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseAuthDataSource {
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
   Future<Either<Failure, String>> register({
    required String email,
    required String password,
  });
}
 

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl( FirebaseAuth firebaseAuth)
      : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return  Left(FirebaseFailure('User not found'));
      }

      return Right(user.uid);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Login failed'));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
   @override
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user == null) return Left(FirebaseFailure('Registration failed'));
      return Right(user.uid);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Registration failed'));
    }
  }
}


