import 'package:flutter/material.dart';
import '../color_extension.dart';
import '../widgets/expense_add.dart';

class NewExpense extends StatelessWidget {
  const NewExpense({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.blue4,
      ),
      backgroundColor: TColor.blue4,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Add Expense',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          const SizedBox(height: 50,),
          const Expanded(
            child: AddExpense()
          ),
        ],
      ),
    );
  }
}
