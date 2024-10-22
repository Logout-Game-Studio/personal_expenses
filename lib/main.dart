import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';
import 'package:personal_expenses/components/transaction_form.dart';
import 'package:personal_expenses/components/transaction_list.dart';
import 'package:personal_expenses/models/transaction.dart';

main() => runApp(PersonalExpensesApp());

class PersonalExpensesApp extends StatelessWidget {
  const PersonalExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade400,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue.shade400,
              titleTextStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaler.scale(20),
                fontWeight: FontWeight.bold,
              )),
          textTheme: TextTheme(
            labelMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          primaryColor: Colors.blue.shade400,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              shape: CircleBorder(), backgroundColor: Colors.blue.shade400),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 1",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 2",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 3",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 1),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 4",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 5",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Sapato 6",
      value: 20.0,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
  ];

  ///Returns list of transactions made in the last seven days
  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (t) {
        return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  void _AddTransaction(String tittle, double value, DateTime date) {
    final nTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: tittle,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(nTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) {
        return t.id == id;
      });
    });
  }

  void _showTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: (t, v, d) {
            _AddTransaction(t, v, d);
            Navigator.of(context).pop();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text("Personal Expenses"),
    );
    final _availableHeight = MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: _availableHeight * 0.3,
                child: Chart(transactions: _recentTransactions)),
            Container(
              height: _availableHeight * 0.7,
              child: TransactionList(
                transactions: _transactions,
                onRemovePressed: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showTransactionFormModal(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
