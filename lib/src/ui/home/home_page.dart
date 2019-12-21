import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';
import 'package:flutter_finance/src/ui/home/home_page_content.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 40.0,
                        margin: EdgeInsets.only(
                            top:  50,
                            right: 10.0),
                        child: Image.asset(
                          'assets/images/nulogo.png',
                          color: Colors.white,
                        )),
                    FutureBuilder<FirebaseUser>(
                      future: _userFinanceBloc.currentUser(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                            child: Text("..."),
                          );
                        else
                          return Container(
                            height: 40.0,
                            margin: EdgeInsets.only(top: 50.0, left: 10.0),
                            alignment: Alignment.center,
                            child: Text(
                              snapshot.data.displayName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                              ),
                            ),
                          );
                      },
                    )
                  ],
                ),
                Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 5),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white70,
                    )),
              ],
            ),
          ),

          HomePageContent(),
        ],
      ),
    );
  }
}
