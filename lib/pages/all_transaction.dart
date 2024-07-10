
import 'package:expense_care/pages/edit_expense_page.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../color_extension.dart';
import '../widgets/edit_expense.dart';

class AllTransaction extends StatelessWidget{
  const AllTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseList = Provider.of<ExpenseProvider>(context).expenses;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:const Text('All Transcations'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount:  expenseList.length,
        itemBuilder: (context,index){
          final expense= expenseList[expenseList.length -index-1];
          final time= DateFormat('HH:mm').format(expense.time);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: TColor.white2
            ),
            child: GestureDetector(
              onLongPressStart: (LongPressStartDetails details) {
                final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                showMenu(
                  context: context,
                  position: RelativeRect.fromRect(
                    details.globalPosition & const Size(40, 40),
                    Offset.zero & overlay.size,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: TColor.grey13,
                  elevation: 10,
                  shadowColor: Colors.greenAccent,
                  items: [
                     const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        title: Text('Delete',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value == 'edit') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditExpensePage(expense: expense,)));
                  } else if (value == 'delete') {
                    Provider.of<ExpenseProvider>(context,listen: false).deleteExpense(expense);
                  }
                });
              },
              child: ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: TColor.primary0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image(
                      image: AssetImage(expense.categoryImageUrl),
                    ),
                  ),
                ),
                title: Text(
                  expense.category,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: TColor.text
                  ),
                ),
                subtitle: Text(
                  expense.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: TColor.secondaryText
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${expense.amount}',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          // fontWeight: FontWeight.bold
                        )
                    ),
                    Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: TColor.secondaryText
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}