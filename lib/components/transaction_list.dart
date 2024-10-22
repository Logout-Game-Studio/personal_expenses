import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onRemovePressed;

  TransactionList({required this.transactions, required this.onRemovePressed});

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, idx) {
              var t = transactions[idx];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    t.title,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(t.date)),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(child: Text('\$ ${t.value}'))),
                  ),
                  trailing: IconButton(
                    color: Theme.of(context).colorScheme.error,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onRemovePressed(t.id);
                    },
                  ),
                ),
              );
            })
        : Column(
            children: [
              Text("No products available"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Image.asset(
                  "assets/images/conjunto-vazio.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
  }
}
