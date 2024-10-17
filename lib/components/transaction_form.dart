import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tittleTextController = TextEditingController();

  final valueTextController = TextEditingController();

  void _submit() {
    var tittle = tittleTextController.text;
    var value = double.tryParse(valueTextController.text) ?? 0.0;
    if (tittle.isNotEmpty) {
      widget.onSubmit(tittle, value);
    }
  }

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
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submit(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //TODO: filter the text input to accept only numeric numbers from keyboard
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.,]')),
              // ],
              controller: valueTextController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text("submit"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
