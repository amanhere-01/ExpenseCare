import 'package:expense_care/color_extension.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:expense_care/widgets/expense_dialogBox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {

  @override
  Widget build(BuildContext context) {
    final expenseList = Provider.of<ExpenseProvider>(context).expenses;
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context,index){
            final expense= expenseList[expenseList.length-index-1];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: TColor.white2
              ),
              child: GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) => ExpenseDialogBox(expense: expense));
                } ,
                child: ListTile(
                  leading: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage(expense.categoryImageUrl),
                      ),
                    ),
                  ),
                  title: Text(expense.category,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: TColor.text
                      )
                  ),
                  trailing: Text('₹${expense.amount}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      )
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
