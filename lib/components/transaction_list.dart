import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onRemovePressed;

  TransactionList({required this.transactions, required this.onRemovePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isNotEmpty
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
                            child: FittedBox(child: Text('R\$ ${t.value}'))),
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
                  // return Card(
                  //   child: Row(
                  //     // crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           margin: EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: Theme.of(ctx).primaryColor,
                  //               width: 2,
                  //             ),
                  //           ),
                  //           padding: EdgeInsets.all(10),
                  //           child: Text(
                  //             "R\$ ${t.value.toStringAsFixed(2)}",
                  //             style:
                  //                 TextStyle(color: Theme.of(ctx).primaryColor),
                  //           )),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             t.title,
                  //             style: Theme.of(context).textTheme.labelMedium,
                  //           ),
                  //           Text(
                  //             DateFormat('d MMM y').format(t.date),
                  //             style: TextStyle(
                  //               color: Color.fromARGB(255, 88, 88, 88),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
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
              ));
  }
}
