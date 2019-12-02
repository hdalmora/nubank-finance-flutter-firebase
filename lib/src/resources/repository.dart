import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_finance/src/resources/authentication_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();

  /// Authentication
  Stream<FirebaseUser> get onAuthStateChange => _authResources.onAuthStateChange;
}