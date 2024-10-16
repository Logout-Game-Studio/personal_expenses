import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final tittleTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final Function(String, double) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Titulo'),
              controller: tittleTextController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: valueTextController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    onSubmit(
                      tittleTextController.text,
                      double.tryParse(valueTextController.text) ?? 0.0,
                    );
                  },
                  child: Icon(Icons.add_circle),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
