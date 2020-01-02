import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';
import 'package:flutter_finance/src/ui/widgets/bottom_action_button.dart';
import 'package:flutter_finance/src/ui/widgets/options_buttons.dart';
import '../../utils/values/colors.dart';
import '../widgets/button_transparent_main.dart';
import '../widgets/form_field_main.dart';
import 'finance_history_page.dart';

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

  UserFinanceBloc _userFinanceBloc;

  bool _hideOptions = true;
  bool _isUserBudgetAlreadySet = false;

  double _expenseProgressValue = 0;

  @override
  void didChangeDependencies() {
    _userFinanceBloc = UserFinanceBlocProvider.of(context);
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

  void showErrorMessage(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message), duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta / minTop;
    print("VALUE: ${_controller.value}");

    if(_controller.value > .5)
      _hideOptions = false;
    else
      _hideOptions = true;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    if (_controller.value > 0.5)
      _controller.fling(velocity: 2);
    else
      _controller.fling(velocity: -2);

  }

  double lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  void _insertNewQuickActionModal(BuildContext context, String title, VoidCallback confirmCallback){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: MediaQuery.of(context).size.height * .7,
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.money_off, size: 35.0,),
                    title: new Text(title, style: TextStyle(fontSize: 26.0),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: ListTile(
                    title: StreamBuilder(
                      stream: _userFinanceBloc.financeValue,
                      builder: (context, snapshot) {
                        return FormFieldMain(
                          hintText: 'Valor...',
                          onChanged: _userFinanceBloc.changeFinanceValue,
                          errorText: snapshot.error,
                          marginLeft: 20.0,
                          marginRight: 20.0,
                          marginTop: 0,
                          textInputType: TextInputType.number,
                          obscured: false,
                        );
                      },
                    ),
                    onTap: () => {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: ListTile(
                    leading: new Icon(Icons.done, size: 28.0,),
                    title: new Text('CONFIRMAR', style: TextStyle(fontSize: 20.0),),
                    onTap: confirmCallback,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

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
                          _userFinanceBloc.signOut();
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
                onTap: () {
                  if(_hideOptions)
                    Navigator.pushNamed(context, FinanceHistoryPage.routeName,
                        arguments: _expenseProgressValue);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8), bottom: Radius.circular(8)),
                  ),
                  child: FutureBuilder<String>(
                    future: _userFinanceBloc.getUserUID(),
                    builder: (context, userUID) {
                      if(!userUID.hasData || userUID.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        );
                      } else {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: _userFinanceBloc.userFinanceDoc(userUID.data),
                          builder: (context, snapshot) {
                            if(snapshot.hasData && snapshot.data.exists) {

                              double totalSpent = snapshot.data['totalSpent'] != null ?
                              snapshot.data['totalSpent'].toDouble() : 0;
                              double budget = snapshot.data['budget'] != null ?
                              snapshot.data['budget'].toDouble() : 0;

                              double availableLimit = budget - totalSpent;

                              if(availableLimit < 0)
                                availableLimit = 0;

                              _expenseProgressValue = totalSpent / budget;

                              _isUserBudgetAlreadySet = true;
                              return Stack(
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
                                            "R\$ " + totalSpent.toString(),
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
                                                " R\$ " + availableLimit.toString(),
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
                                    child: Hero(
                                      tag: 'progress-budget',
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Container(
                                          height: 10,
                                          width: MediaQuery.of(context).size.height*.25,
                                          child: LinearProgressIndicator(
                                            backgroundColor: Colors.green,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                            value: _expenseProgressValue,
                                          ),
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
                                      child:
                                        StreamBuilder(
                                          stream: _userFinanceBloc.lastExpense(userUID.data),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData) {
                                              List<DocumentSnapshot> docs = snapshot.data.documents;

                                              if(docs.length > 0) {
                                                return Center(
                                                  child:
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "Gasto mais recente no valor de",
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 15.0
                                                          ),
                                                        ),
                                                        Text(
                                                          "R\$ " + docs[0]['value'].toString(),
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 15.0
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                );
                                              } else {
                                                return Center(
                                                  child: Text(
                                                    "Nenhum gasto recente",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15.0
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              _isUserBudgetAlreadySet = false;
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "You must set the monthly budget first",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0
                                      ),
                                    ),

                                    SizedBox(height: 30.0,),
                                    ButtonTransparentMain(
                                      callback: () async {
                                        _insertNewQuickActionModal(context, "Set monthly Budget", () {
                                          if(_userFinanceBloc.validateFinance()) {
                                            _userFinanceBloc.setUserBudget();
                                          }
                                        });
                                      },
                                      height: 60.0,
                                      width: MediaQuery.of(context).size.width,
                                      fontSize: 20.0,
                                      marginRight: 40.0,
                                      marginLeft: 40.0,
                                      text: 'Set monthly Budget',
                                      borderColor: ColorConstant.colorMainPurple,
                                      textColor: ColorConstant.colorMainPurple,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
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
                    callback: () {
                      if(_isUserBudgetAlreadySet)
                        _insertNewQuickActionModal(context, "Incluir Despesa", () {
                          if(_userFinanceBloc.validateFinance()) {
                            _userFinanceBloc.addNewExpense();
                          }
                        });
                      else
                        showErrorMessage(context, "You must set your monthly budget first");
                    },
                  ),
                  BottomActionButton(
                    icon: Icons.monetization_on,
                    iconSize: 32.0,
                    actionText: "Budget mensal",
                    callback: () {
                      _insertNewQuickActionModal(context, "Setar Budget Mensal", () {
                        if(_userFinanceBloc.validateFinance()) {
                          _userFinanceBloc.setUserBudget();
                        }
                      });
                    }
                  ),
                  BottomActionButton(
                    icon: Icons.group_add,
                    iconSize: 32.0,
                    actionText: "Indicar amigos",
                    callback: () {

                    },
                  ),
                  BottomActionButton(
                    icon: Icons.help_outline,
                    iconSize: 32.0,
                    actionText: "Sobre",
                    callback: () {

                    },
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
