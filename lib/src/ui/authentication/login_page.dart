import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';


const double minHeight = 60.0;
const double maxHeight = 600.0;
const double minWidth = 250.0;
const double maxWidth = 400.0;
const double maxBottomButtonsMargin = 15;
const double minBottomButtonsMargin = -170;
const double maxFormsContainerMargin = 160;
const double minFormsContainerMargin = 20;


class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController _controller;

  bool _loginContainerOpened = false;
  bool _signUpContainerOpened = false;

  double _loginContainerHeight = minHeight;
  double _loginContainerWidth = minWidth;

  double _signUpContainerHeight = minHeight;
  double _signUpContainerWidth = minWidth;

  double _formsContainerMargin = maxFormsContainerMargin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _toggleLogin() {
    setState(() {
      if (_signUpContainerOpened) {
        _signUpContainerHeight = minHeight;
        _signUpContainerWidth = minWidth;
        _signUpContainerOpened = false;
      }

      _loginContainerHeight =
          _loginContainerHeight == maxHeight ? minHeight : maxHeight;
      _loginContainerWidth =
          _loginContainerWidth == maxWidth ? minWidth : maxWidth;

      _formsContainerMargin = _formsContainerMargin == minFormsContainerMargin? maxFormsContainerMargin : minFormsContainerMargin;
      _loginContainerOpened = !_loginContainerOpened;
    });

    _toggleBottomButtons();

  }

  void _toggleSignUp() {
    setState(() {
      if (_loginContainerOpened) {
        _loginContainerHeight = minHeight;
        _loginContainerWidth = minWidth;
        _loginContainerOpened = false;
      }

      _signUpContainerHeight =
          _signUpContainerHeight == maxHeight ? minHeight : maxHeight;
      _signUpContainerWidth =
          _signUpContainerWidth == maxWidth ? minWidth : maxWidth;

      _formsContainerMargin = _formsContainerMargin == minFormsContainerMargin? maxFormsContainerMargin : minFormsContainerMargin;
      _signUpContainerOpened = !_signUpContainerOpened;

      _toggleBottomButtons();
    });
  }

  void _toggleBottomButtons() {
    final bool isAnyContainerExpanded = _controller.status == AnimationStatus.completed;

    _controller.fling(velocity: isAnyContainerExpanded ? -2 : 2);
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstant.colorMainPurple,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned.fill(
                  top: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
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
                        ],
                      )
                  ),
                );
              },
            ),

            ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  margin: EdgeInsets.only(top: _formsContainerMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: _loginContainerOpened ? Container()
                        : GestureDetector(
                          onTap: () {
                            if (!_signUpContainerOpened && !_loginContainerOpened) {
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

                                    Positioned.fill(
                                      top: 70.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(0xCC000000)
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(0))
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: 'Email...',
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: ColorConstant.colorMainPurple),
                                                  ),
                                                ),
                                              ),
                                            ),


                                            Container(
                                              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(0xCC000000)
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(0))
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: 'Password...',
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: ColorConstant.colorMainPurple),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(0xCC000000)
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(0))
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: 'Display Name...',
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: ColorConstant.colorMainPurple),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 30.0, right: 30.0),
                                            alignment: Alignment.center,
                                            height: 60.0,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorConstant.colorMainPurple
                                                )
                                            ),
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: ColorConstant.colorMainPurple,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20.0
                                              ),
                                            ),
                                          ),
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
                      ),

                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: _signUpContainerOpened ? Container()
                        :                       GestureDetector(
                          onTap: () {
                            if (!_loginContainerOpened && !_signUpContainerOpened) {
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


                                    Positioned.fill(
                                      top: 70.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(0xCC000000)
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(0))
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: 'Email...',
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: ColorConstant.colorMainPurple),
                                                  ),
                                                ),
                                              ),
                                            ),


                                            Container(
                                              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color(0xCC000000)
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(0))
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: 'Password...',
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: ColorConstant.colorMainPurple),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),



                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 30.0, right: 30.0),
                                            alignment: Alignment.center,
                                            height: 60.0,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorConstant.colorMainPurple
                                                )
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: ColorConstant.colorMainPurple,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20.0
                                              ),
                                            ),
                                          ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned.fill(
                  bottom: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                  child: Align(
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
                );
              },
            ),
          ],
        ));
  }
}
