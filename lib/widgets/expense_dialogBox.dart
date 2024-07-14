import 'package:expense_care/pages/edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../color_extension.dart';
import '../database/database.dart';
import '../providers/expense_provider.dart';
import 'edit_expense.dart';


class ExpenseDialogBox extends StatelessWidget {
  final Expense expense;
  const ExpenseDialogBox({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd-MM-yyyy').format(expense.date);
    final time = DateFormat('hh:mm a').format(expense.time);
    return Dialog(
      backgroundColor: TColor.cyan,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.greenAccent,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(expense.categoryImageUrl),
                ),
              ) ,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                color: TColor.cyan2,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  Text(
                    expense.category,
                    style: TextStyle(
                        fontSize: 30,
                        color: TColor.text,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    expense.description,
                    style: TextStyle(
                        fontSize: 20,
                        color: TColor.text
                    ),
                  ),
                ],
              ),
            ),
            Text('₹${expense.amount}',
              style:  const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 5,),
            Text('$date | $time',
              style: TextStyle(
                  color: TColor.secondaryText
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.green,
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: TColor.green2
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditExpensePage(expense: expense,))).then(
                        (_){
                          Navigator.pop(context);
                        });
                  },
                  label: Text(
                    'Edit',
                    style: TextStyle(
                      color: TColor.green2,
                      fontSize: 16
                    ),
                  )
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.red,
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: TColor.red1,
                  ),
                  onPressed: (){
                    Provider.of<ExpenseProvider>(context,listen: false).deleteExpense(expense).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: Center(
                            child: Text(
                              'Deleted!',
                              style: TextStyle(
                                color: TColor.black1,
                              ),
                            ),
                          ),
                          backgroundColor: TColor.black8,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  label: Text(
                    'Delete',
                    style: TextStyle(
                      color: TColor.red1,
                      fontSize: 16
                    ),
                  )
                ),
              ],
            )
          ]
        ),
      )
    );
  }
}



