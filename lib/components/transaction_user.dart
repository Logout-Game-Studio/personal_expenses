import 'dart:math';
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/transaction_form.dart';
import 'package:personal_expenses/components/transaction_list.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(transactions: _transactions),
        TransactionForm(
          onSubmit: _AddTransaction,
        ),
      ],
    );
  }
}
