

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/root_page.dart';
import 'package:flutter_finance/src/ui/authentication/login_page.dart';
import 'package:flutter_finance/src/ui/home/home_page.dart';

class NuFinance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nu Finance',
      theme: ThemeData(
        accentColor: Color(0xFF6d2177),
        fontFamily: 'SF Pro Display',
      ),
      initialRoute: RootPage.routeName,
      routes: {
        RootPage.routeName: (context) => RootPage(),
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }

}