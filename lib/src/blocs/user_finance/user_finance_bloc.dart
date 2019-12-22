

import 'package:firebase_auth/firebase_auth.dart';

import '../../resources/repository.dart';
import '../bloc.dart';

class UserFinanceBloc implements Bloc {
  final _repository = Repository();



  Future<FirebaseUser> currentUser() => _repository.getCurrentUser();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}