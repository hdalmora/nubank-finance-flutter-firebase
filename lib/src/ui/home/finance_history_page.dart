import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';

class FinanceHistoryPage extends StatefulWidget {
  static const String routeName = 'finance_history_page';

  @override
  _FinanceHistoryPageState createState() => _FinanceHistoryPageState();
}

class _FinanceHistoryPageState extends State<FinanceHistoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UserFinanceBloc _userFinanceBloc;

  @override
  void didChangeDependencies() {
    _userFinanceBloc = UserFinanceBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Container(height: 40, child: Image.asset('assets/images/nulogo.png', fit: BoxFit.fitHeight)),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black87,
          iconSize: 45.0,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[


        ],
      ),
    );
  }
}
