import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _tittleTextController = TextEditingController();
  final _valueTextController = TextEditingController();
  DateTime? _selectedDate = null;

  void _submit() {
    var tittle = _tittleTextController.text;
    var value = double.tryParse(_valueTextController.text) ?? 0.0;
    if (tittle.isNotEmpty && _selectedDate != null) {
      widget.onSubmit(tittle, value, _selectedDate!);
    }
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Tittle (name of the product)'),
              controller: _tittleTextController,
              onSubmitted: (_) => _submit(),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Value (\$)'),
              onSubmitted: (_) => _submit(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //TODO: filter the text input to accept only numeric numbers from keyboard
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.,]')),
              // ],
              controller: _valueTextController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date informed!'
                      : "Informed date: ${DateFormat('d/M/y').format(_selectedDate!)}"),
                ),
                TextButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Text(
                    'select date',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      "submit",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
