import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});
  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> register(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
