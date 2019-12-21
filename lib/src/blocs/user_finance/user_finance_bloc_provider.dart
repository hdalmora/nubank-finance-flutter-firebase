import 'package:flutter/material.dart';

import 'user_finance_bloc.dart';

class UserFinanceBlocProvider extends InheritedWidget{
  final bloc = UserFinanceBloc();

  UserFinanceBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static UserFinanceBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserFinanceBlocProvider) as UserFinanceBlocProvider).bloc;
  }
}