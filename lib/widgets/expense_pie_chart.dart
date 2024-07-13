import 'package:expense_care/categories_list.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../color_extension.dart';

class ExpensePieChart extends StatefulWidget {
  final int monthNumber;
  final double totalMonthExpense;
  const ExpensePieChart({super.key, required this.monthNumber, required this.totalMonthExpense});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {


  Future<double> getCategoryValue(int monthNumber,String selectedCategory) async{
    return await Provider.of<ExpenseProvider>(context, listen: false).monthlyCategoryExpenses(monthNumber, selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(categoriesType.map((data) => getCategoryValue(widget.monthNumber, data['title'] as String)).toList()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: RefreshProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 10,
                  shadowColor: TColor.peach,
                  color: TColor.black2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        swapAnimationDuration: const Duration(seconds: 1),
                        PieChartData(
                          centerSpaceRadius: MediaQuery.of(context).size.width/4,
                          sectionsSpace: 0,
                          sections: categoriesType
                              .asMap()
                              .map<int, PieChartSectionData>((index, data) {    // here data = categoryType[index]
                                final value = PieChartSectionData(
                                  color: Color(data['color'] as int),
                                  value: snapshot.data[index],
                                  // title: data['title'] as String ,
                                  showTitle: false,
                                  // titleStyle: TextStyle(
                                  //   fontSize: 16,
                                  //   color: TColor.white1
                                  // ),
                                  // badgeWidget: SizedBox(
                                  //   width: 30,
                                  //   height: 30,
                                  //   child: Image(
                                  //     image: AssetImage(data['imageUrl'] as String,),
                                  //   ),
                                  // ),
                                  // badgePositionPercentageOffset: 0.5
                                );
                                return MapEntry(index, value);
                              }).values.toList(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Expense",
                            style: TextStyle(
                              fontSize: 14,
                              color: TColor.white5,
                            ),
                          ),
                          Text(
                            '₹${widget.totalMonthExpense}',
                            style: TextStyle(
                              fontSize: 40,
                              color: TColor.white1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration:    BoxDecoration(
                      color: TColor.black4,
                  ) ,
                  child:  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount:categoriesType.length,
                          itemBuilder: (context,index){
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: TColor.black1
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(categoriesType[index]['color'] as int),
                                  ),
                                ),
                                title: Text(
                                  categoriesType[index]['title'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: TColor.white4,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                trailing: Text(
                                  '₹${snapshot.data[index]}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600

                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
      // child:
    );
  }
}
