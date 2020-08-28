import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
    
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(

              //textTheme: ThemeData.dark().textTheme
              )),
      title: 'Personal expense',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    // Transactions(
    //   id: 't1',
    //   title: 'Colddrink',
    //   amount: 45,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 't2',
    //   title: 'Chips',
    //   amount: 20,
    //   date: DateTime.now(),
    // )
  ];

  bool _showChart = false;

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
      amount: txAmount,
      title: txTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    
    final isLanscape = mediaQuery.orientation == Orientation.landscape;


    var add = Icons.add;
    final appBar = AppBar(
      title: Text("Personal Expense"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    final txListWidget =  Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            if(isLanscape)   
            Row(
              
              mainAxisAlignment : MainAxisAlignment.center,
              children: <Widget>[
              
              Text("Show Chart"),
              Switch(value: _showChart, onChanged: (val) {
                setState(() {
                  _showChart = val;
                  
                });
              })
            ],),

            if(!isLanscape)
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            
            if(!isLanscape)
            txListWidget,


            if(isLanscape)
           _showChart ? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: Chart(_recentTransactions))
                :txListWidget,
           
            // Container(
            //     height: (mediaQuery.size.height -
            //             appBar.preferredSize.height -
            //             mediaQuery.padding.top) *
            //         0.7,
            //     child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            add,
            color: Colors.purple,
            size: 35,
          ),
          backgroundColor: Colors.white,
          onPressed: () => {_startAddNewTransaction(context)}),
    );
  }
}
