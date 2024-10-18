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
                fontSize: 20,
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
              backgroundColor: Colors.greenAccent.shade400),
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
      id: "t1",
      title: "shoes",
      value: 30.0,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t2",
      title: "super shoes",
      value: 36.0,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t3",
      title: "super shoes",
      value: 36.0,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t4",
      title: "super shoes",
      value: 36.0,
      date: DateTime.now().subtract(Duration(days: 4)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chart(transactions: _recentTransactions),
            TransactionList(
              transactions: _transactions,
              onRemovePressed: _removeTransaction,
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
