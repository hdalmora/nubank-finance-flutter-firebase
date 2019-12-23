
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_finance/src/utils/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/repository.dart';
import '../bloc.dart';

class UserFinanceBloc implements Bloc {
  final _repository = Repository();



  Stream<FirebaseUser> get currentUser => _repository.onAuthStateChange;
  Future<void> signOut() => _repository.signOut();

  String getCurrentUserDisplayNameFromPrefs(SharedPreferences prefs) {
    PrefsManager prefsMang = PrefsManager();
    String displayName = prefsMang.getCurrentUserDisplayName(prefs);
    print("CURRENT DISPLAYNAME: " + displayName);
    return displayName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}