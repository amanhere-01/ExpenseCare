import 'package:expense_care/database/database.dart';
import 'package:expense_care/widgets/edit_expense.dart';
import 'package:flutter/material.dart';

import '../color_extension.dart';

class EditExpensePage extends StatelessWidget {
  final Expense expense;
  const EditExpensePage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Colors.greenAccent,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Edit Expense',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          const SizedBox(height: 50,),
           Expanded(
              child: EditExpense(expense: expense)
          ),
        ],
      ),
    );
  }
}
