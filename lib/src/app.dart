

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/authentication/authentication_bloc_provider.dart';
import 'package:flutter_finance/src/root_page.dart';
import 'package:flutter_finance/src/ui/authentication/login_page.dart';
import 'package:flutter_finance/src/ui/home/finance_history_page.dart';
import 'package:flutter_finance/src/ui/home/home_page.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';

import 'blocs/user_finance/user_finance_bloc_provider.dart';

class NuFinance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticationBlocProvider(
      child: UserFinanceBlocProvider(
        child: MaterialApp(
          title: 'Nu Finance',
          theme: ThemeData(
            accentColor: ColorConstant.colorMainPurple,
            fontFamily: 'SF Pro Display',
          ),
          initialRoute: RootPage.routeName,
          routes: {
            RootPage.routeName: (context) => RootPage(),
            LoginPage.routeName: (context) => LoginPage(),
            HomePage.routeName: (context) => HomePage(),
            FinanceHistoryPage.routeName: (context) => FinanceHistoryPage()
          },
        ),
      ),
    );
  }

}