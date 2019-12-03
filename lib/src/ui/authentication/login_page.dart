import 'package:flutter/material.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const double minHeight = 60.0;
  static const double maxHeight = 550.0;
  static const double minWidth = 250.0;
  static const double maxWidth = 400.0;

  bool _loginContainerOpened = false;
  bool _signUpContainerOpened = false;

  double _loginContainerHeight = minHeight;
  double _loginContainerWidth = minWidth;

  double _signUpContainerHeight = minHeight;
  double _signUpContainerWidth = minWidth;

  @override
  void didChangeDependencies() {
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

  void _toggleLogin() {
    setState(() {
      _loginContainerHeight =
          _loginContainerHeight == maxHeight ? minHeight : maxHeight;
      _loginContainerWidth =
          _loginContainerWidth == maxWidth ? minWidth : maxWidth;

      if (_signUpContainerOpened) {
        _signUpContainerHeight = minHeight;
        _signUpContainerWidth = minWidth;
        _signUpContainerOpened = false;
      }
      _loginContainerOpened = !_loginContainerOpened;
    });
  }

  void _toggleSignUp() {
    setState(() {
      _signUpContainerHeight =
          _signUpContainerHeight == maxHeight ? minHeight : maxHeight;
      _signUpContainerWidth =
          _signUpContainerWidth == maxWidth ? minWidth : maxWidth;

      if (_loginContainerOpened) {
        _loginContainerHeight = minHeight;
        _loginContainerWidth = minWidth;
        _loginContainerOpened = false;
      }
      _signUpContainerOpened = !_signUpContainerOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstant.colorMainPurple,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 60.0,
                        margin: EdgeInsets.only(top: 50.0),
                        child: Image.asset(
                          'assets/images/nulogo.png',
                          color: Colors.white,
                        )),
                    Container(
                        height: 60.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 5),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white70,
                        )),
                    GestureDetector(
                      onTap: () {
                        if (!_signUpContainerOpened) {
                          _toggleSignUp();
                        }
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 5.0),
                        width: _signUpContainerWidth,
                        height: _signUpContainerHeight,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _signUpContainerOpened
                              ? Container(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 5,
                                        left: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_signUpContainerOpened) {
                                              _toggleSignUp();
                                            }
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 40.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25.0),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_loginContainerOpened) {
                          _toggleLogin();
                        }
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 5.0),
                        width: _loginContainerWidth,
                        height: _loginContainerHeight,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _loginContainerOpened
                              ? Container(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 5,
                                        left: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_loginContainerOpened) {
                                              _toggleLogin();
                                            }
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 40.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25.0),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _loginContainerOpened || _signUpContainerOpened
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          height: 55.0,
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              color: Colors.white,
                              child:
                                  Image.asset('assets/images/googleicon.png'),
                            ),
                          ),
                        )),
                  ),
          ],
        ));
  }
}
