import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_finance/src/resources/authentication_resources.dart';
import 'package:flutter_finance/src/resources/user_finance_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();
  final _userFinanceResources = UserFinanceResources();

  /// Authentication
  Stream<FirebaseUser> get onAuthStateChange => _authResources.onAuthStateChange;
  Future<int> loginWithEmailAndPassword(String email, String password) => _authResources.loginWithEmailAndPassword(email, password);
  Future<int> signUpWithEmailAndPassword(String email, String password, String displayName) => _authResources.signUpWithEmailAndPassword(email, password, displayName);
  Future<void> signOut() => _authResources.signOut;

  /// User Finance

}