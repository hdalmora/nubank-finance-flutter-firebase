import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/resources/repository.dart';
import 'package:flutter_finance/src/ui/authentication/login_page.dart';
import 'package:flutter_finance/src/ui/home/home_page.dart';

class RootPage extends StatefulWidget {
  static const String routeName = 'root_page';

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final Repository _repository = Repository();
  Stream<FirebaseUser> _currentUser;

  @override
  void initState() {
    _currentUser = _repository.onAuthStateChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return snapshot.hasData ? HomePage() : LoginPage();
      },
    );
  }
}
