import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';
import 'package:flutter_finance/src/ui/widgets/bottom_action_button.dart';
import 'package:flutter_finance/src/ui/widgets/options_buttons.dart';
import '../widgets/button_transparent_main.dart';

const double minTop = 145;
const double maxQuickActionsMargin = 50;
const double minQuickActionsMargin = -170;

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  UserFinanceBloc _userFianceBloc;

  bool _hideOptions = true;

  @override
  void didChangeDependencies() {
    _userFianceBloc = UserFinanceBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta / minTop;
    print("VALUE: ${_controller.value}");
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    if (_controller.value > 0.5) {
      _controller.fling(velocity: 2);
      _hideOptions = false;
    } else {
    _controller.fling(velocity: -2);
    _hideOptions = true;
    }

  }

  double lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    double maxTop = MediaQuery.of(context).size.height * .9;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height * .60,
              left: 0,
              right: 0,
              top: minTop,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _hideOptions == false ? Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.white70,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      OptionsButton(
                        icon: Icons.help_outline,
                        text: "Sobre o App",
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.white70,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      OptionsButton(
                        icon: Icons.perm_identity,
                        text: "Meu Perfil",
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.white70,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      OptionsButton(
                        icon: Icons.settings,
                        text: "Configurações do App",
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.white70,
                      ),

                      SizedBox(height: 25,),

                      ButtonTransparentMain(
                        callback: () {
                          _userFianceBloc.signOut();
                        },
                        fontSize: 20.0,
                        height: 50,
                        marginLeft: 0,
                        marginRight: 0,
                        text: "SAIR DA CONTA",
                        borderColor: Colors.white70,
                        textColor: Colors.white70,
                      )
                    ],
                  ),
                ) : Container(),
              ),
            ),
            Positioned(
              height: MediaQuery.of(context).size.height * .45,
              left: 0,
              right: 0,
              top: lerp(minTop, maxTop),
              child: GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8), bottom: Radius.circular(8)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Icon(
                          Icons.credit_card,
                          color: Colors.black38,
                          size: 32.0,
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).size.height*.14,
                        left: 16,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "GASTO ATUAL",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),
                              ),
                              Text(
                                "R\$ 1500.00",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30.0
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Limite disponível ",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0
                                    ),
                                  ),
                                  Text(
                                    " R\$ 2545.00",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: 25,
                        top: 20,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Container(
                            height: 10,
                            width: MediaQuery.of(context).size.height*.25,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.green,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                              value: .7,
                            ),
                          ),
                        ),
                      ),


                      Positioned(
                        height: 90.0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.black12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Compra mais recente em ",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0
                                ),
                              ),
                              Text(
                                "Restaurante" + " no valor de " + " R\$ 32.45",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              height: 145,
              left: 0,
              right: 0,
              bottom: lerp(maxQuickActionsMargin, minQuickActionsMargin),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  BottomActionButton(
                    icon: Icons.money_off,
                    iconSize: 32.0,
                    actionText: "Incluir despesa",
                  ),
                  BottomActionButton(
                    icon: Icons.attach_money,
                    iconSize: 32.0,
                    actionText: "Incluir ganho",
                  ),
                  BottomActionButton(
                    icon: Icons.monetization_on,
                    iconSize: 32.0,
                    actionText: "Budget mensal",
                  ),
                  BottomActionButton(
                    icon: Icons.group_add,
                    iconSize: 32.0,
                    actionText: "Indicar amigos",
                  ),
                  BottomActionButton(
                    icon: Icons.help_outline,
                    iconSize: 32.0,
                    actionText: "Sobre",
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
