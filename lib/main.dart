import 'dart:math';

import 'package:flutter/material.dart';
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
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade400),
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
  final _transactions = [
    Transaction(
      id: "t1",
      title: "shoes",
      value: 30.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "super shoes",
      value: 36.0,
      date: DateTime.now(),
    ),
  ];

  void _AddTransaction(String tittle, double value) {
    final nTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: tittle,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(nTransaction);
    });
  }

  void _showTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: (t, v) {
            _AddTransaction(t, v);
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
            Container(
              child: Card(elevation: 5, child: Text("Gráficos")),
            ),
            TransactionList(transactions: _transactions),
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
