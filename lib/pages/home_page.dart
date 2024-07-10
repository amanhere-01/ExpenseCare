import 'package:expense_care/color_extension.dart';
import 'package:expense_care/pages/all_transaction.dart';
import 'package:expense_care/pages/new_expense.dart';
import 'package:expense_care/widgets/recent_transactions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Center(
                  child: Text(
                    "Total Expense",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ),
                Text(
                  '₹ 2000',
                  style: Theme.of(context).textTheme.displayLarge ,
                ),
                // Flexible(
                //   flex: 2,
                //   child: BarChart(
                //     swapAnimationDuration: const Duration(seconds:1),
                //       BarChartData(
                //         // titlesData: [
                //         //
                //         // ]
                //       )
                //   ),
                // ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration:   BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                    ) ,
                    child:  Column(
                      children: [
                        Row(
                          children: [
                            Text('Recent Transactions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: TColor.text
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllTransaction()));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: TColor.secondaryText,
                                  foregroundColor: Colors.black
                                ),
                                child: const Text('See All',)
                            )
                          ],
                        ),
                        const RecentTransactions()
                        // Expanded(
                        //   child: RecentTransactions()
                        // )
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home_filled),
      //       label: 'Home'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.credit_card),
      //         label: 'Transactions'
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.secondaryText,
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context) => const NewExpense()));
        },
        child: const Icon(Icons.add),

      )
    );
  }
}

