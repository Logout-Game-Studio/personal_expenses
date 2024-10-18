import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/chart_bar.dart';
import 'package:personal_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart({required this.transactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        if (_isSameDate(transactions[i].date, weekDay)) {
          sum += transactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': sum,
      };
    }).reversed.toList();
  }

  bool _isSameDate(DateTime a, DateTime b) {
    bool isSameDate = a.year == b.year && a.month == b.month && a.day == b.day;
    return isSameDate;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, t) {
      return sum + (t['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions.map((t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: t['day'] as String,
                value: t['value'] as double,
                percentage: t['value'] as double == 0
                    ? 0
                    : (t['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
