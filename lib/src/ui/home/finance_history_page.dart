import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc.dart';
import 'package:flutter_finance/src/blocs/user_finance/user_finance_bloc_provider.dart';
import 'package:flutter_finance/src/models/expense_model.dart';

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
    double expenseProgressValue = ModalRoute.of(context).settings.arguments;

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
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: FutureBuilder<String>(
              future: _userFinanceBloc.getUserUID(),
              builder: (context, snapshot) {
                if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                } else {
                  return StreamBuilder<QuerySnapshot>(
                    stream: _userFinanceBloc.expenseList(snapshot.data),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        List<DocumentSnapshot> docs = snapshot.data.documents;
                        List<ExpenseModel> expensesList = List<ExpenseModel>();

                        docs.forEach((doc) {
                          expensesList.add(ExpenseModel.fromDocument(doc));
                        });

                        if(expensesList.isNotEmpty) {
                          return ListView.builder(
                            itemCount: expensesList.length,
                            itemBuilder: (context, position) {
                              return ExpenseCard(
                                value: expensesList[position].expenseValue.toString(),
                                isLastOne: position == expensesList.length - 1
                              );
                            }
                          );
                        } else {
                          // No data -- Empty collection
                          return Center(child: Text('No expenses to show'),);
                        }
                      } else {
                        // No data -- Error
                        return Container();
                      }
                    }
                  );
                }
              }
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: Hero(
              tag: 'progress-budget',
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  height: 10,
                  width: MediaQuery.of(context).size.height,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.green,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    value: expenseProgressValue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String value;
  final bool isLastOne;

  const ExpenseCard({
    Key key,
    @required this.value,
    @required this.isLastOne
  }): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Colors.grey, // button color
                  child: SizedBox(width: 22, height: 22,),
                ),
              ),
              !isLastOne ? Container(
                height: 45.0,
                width: 1.5,
                color: Colors.grey,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              ) : Container(),
            ],
          ),

          Container(
            margin: EdgeInsets.only(left: 15.0, top: 5.0),
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

