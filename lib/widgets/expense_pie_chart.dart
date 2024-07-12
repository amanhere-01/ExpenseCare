import 'package:expense_care/categories_list.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePieChart extends StatefulWidget {
  final int monthNumber;
  const ExpensePieChart({super.key, required this.monthNumber});

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
          return PieChart(
            swapAnimationDuration: const Duration(milliseconds: 200),
            PieChartData(
              sections: categoriesType
                  .asMap()
                  .map<int, PieChartSectionData>((index, data) {    // here data = categoryType[index]
                    final value = PieChartSectionData(
                      color: Color(data['color'] as int),
                      value: snapshot.data[index],
                      title: data['title'] as String,
                    );
                    return MapEntry(index, value);
                  }).values.toList(),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
      // child:
    );
  }
}
