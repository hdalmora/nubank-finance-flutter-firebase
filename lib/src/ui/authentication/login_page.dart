import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_finance/src/ui/widgets/button_transparent_main.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';
import 'package:flutter_finance/src/ui/widgets/form_field_main.dart';


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

  void _toggleAuthButtonsScale(bool isLogin) {
    setState(() {
      if(isLogin) {
        _loginContainerHeight = _loginContainerHeight == maxHeight ? minHeight : maxHeight;
        _loginContainerWidth = _loginContainerWidth == maxWidth ? minWidth : maxWidth;
        _scaleDownSignUpBtn();
        _loginContainerOpened = !_loginContainerOpened;
      } else {
        _signUpContainerHeight = _signUpContainerHeight == maxHeight ? minHeight : maxHeight;
        _signUpContainerWidth = _signUpContainerWidth == maxWidth ? minWidth : maxWidth;
        _scaleDownLoginBtn();
        _signUpContainerOpened = !_signUpContainerOpened;
      }

      _formsContainerMargin = _formsContainerMargin == minFormsContainerMargin? maxFormsContainerMargin : minFormsContainerMargin;
    });
  }

  void _scaleDownSignUpBtn() {
    if (_signUpContainerOpened) {
      _signUpContainerHeight = minHeight;
      _signUpContainerWidth = minWidth;
      _signUpContainerOpened = false;
    }
  }

  void _scaleDownLoginBtn() {
    if (_loginContainerOpened) {
      _loginContainerHeight = minHeight;
      _loginContainerWidth = minWidth;
      _loginContainerOpened = false;
    }
  }

  void _toggleNuLogoAndGoogleBtn() {
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

                      /// Sign Up Button Animated ------
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: _loginContainerOpened ? Container()
                        : GestureDetector(
                          onTap: () {
                            if (!_signUpContainerOpened && !_loginContainerOpened) {
                              _toggleAuthButtonsScale(false);
                              _toggleNuLogoAndGoogleBtn();
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
                                            _toggleAuthButtonsScale(false);
                                            _toggleNuLogoAndGoogleBtn();
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

                                            const FormFieldMain(
                                              hintText: 'Email...',
                                              marginLeft: 20.0,
                                              marginRight: 20.0,
                                              marginTop: 0,
                                              textInputType: TextInputType.text,
                                              obscured: false,
                                            ),

                                            const FormFieldMain(
                                              hintText: 'Password...',
                                              marginLeft: 20.0,
                                              marginRight: 20.0,
                                              marginTop: 15.0,
                                              textInputType: TextInputType.text,
                                              obscured: true,
                                            ),

                                            const FormFieldMain(
                                              hintText: 'Display Name...',
                                              marginLeft: 20.0,
                                              marginRight: 20.0,
                                              marginTop: 15.0,
                                              textInputType: TextInputType.text,
                                              obscured: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTransparentMain(
                                          callback: () {

                                          },
                                          height: 60.0,
                                          width: MediaQuery.of(context).size.width,
                                          fontSize: 20.0,
                                          marginRight: 30.0,
                                          marginLeft: 30.0,
                                          text: 'Sign Up',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : Text(
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
                      /// End Sign Up Button Animated ------

                      /// Login Button Animated ------
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: _signUpContainerOpened ? Container()
                        : GestureDetector(
                          onTap: () {
                            if (!_loginContainerOpened && !_signUpContainerOpened) {
                              _toggleAuthButtonsScale(true);
                              _toggleNuLogoAndGoogleBtn();
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

                                    /// Close button ------
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_loginContainerOpened) {
                                            _toggleAuthButtonsScale(true);
                                            _toggleNuLogoAndGoogleBtn();
                                          }
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 40.0,
                                        ),
                                      ),
                                    ),
                                    /// End Close Button ------

                                    Positioned.fill(
                                      top: 70.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[

                                            const FormFieldMain(
                                              hintText: 'Email...',
                                              marginLeft: 20.0,
                                              marginRight: 20.0,
                                              marginTop: 0,
                                              textInputType: TextInputType.text,
                                              obscured: false,
                                            ),

                                            const FormFieldMain(
                                              hintText: 'Password...',
                                              marginLeft: 20.0,
                                              marginRight: 20.0,
                                              marginTop: 15.0,
                                              textInputType: TextInputType.text,
                                              obscured: true,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTransparentMain(
                                          callback: () {

                                          },
                                          height: 60.0,
                                          width: MediaQuery.of(context).size.width,
                                          fontSize: 20.0,
                                          marginRight: 30.0,
                                          marginLeft: 30.0,
                                          text: 'Login',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : Text(
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
                      /// End Login Button Animated -------
                    ],
                  ),
                ),
              ],
            ),

            /// Google Login Button -------
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
            /// End Google Login Button -------
          ],
        ));
  }
}
