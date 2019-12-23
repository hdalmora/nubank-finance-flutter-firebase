import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';
import 'package:flutter_finance/src/ui/home/home_page_content.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UserFinanceBloc _userFinanceBloc;
  SharedPreferences _prefs;

  @override
  void didChangeDependencies() {
    _userFinanceBloc = UserFinanceBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
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
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 40.0,
                      margin: EdgeInsets.only(top: 50, right: 10.0),
                      child: Image.asset(
                        'assets/images/nulogo.png',
                        color: Colors.white,
                      )),
                  StreamBuilder<FirebaseUser>(
                    stream: _userFinanceBloc.currentUser,
                    builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if(snapshot.hasData) {
                        FirebaseUser user = snapshot.data;

                        String displayName = user.displayName;

                        if(displayName == null) {
                          displayName = _userFinanceBloc.getCurrentUserDisplayNameFromPrefs(_prefs);
                        }

                        if(displayName != null) {
                          return Container(
                            height: 50.0,
                            margin: EdgeInsets.only(top: 50.0, left: 10.0),
                            alignment: Alignment.center,
                            child: Text(
                              displayName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
              Container(
                  height: 35.0,
                  margin: EdgeInsets.only(top: 10.0, bottom: 5),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white70,
                  )
              ),
            ],
          ),

          HomePageContent()

        ],
      ),
    );
  }
}
