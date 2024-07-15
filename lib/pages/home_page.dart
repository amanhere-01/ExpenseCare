import 'package:expense_care/data/color_list.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:expense_care/widgets/expense_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/month_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedMonth;
  late int selectedMonthNumber;

  @override
  void initState(){
    super.initState();
    selectedMonth= DateFormat.MMMM().format(DateTime.now());
    selectedMonthNumber= DateTime.now().month;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: TColor.white2
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: TColor.black4
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: selectedMonth,
                  borderRadius: BorderRadius.circular(20),
                  dropdownColor: TColor.black6,
                  style: TextStyle(
                      fontSize: 16,
                      color: TColor.white4,
                      fontWeight: FontWeight.w500
                  ),
                  icon: Icon(Icons.keyboard_arrow_down_rounded,color: TColor.white4,),
                  iconSize: 20,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMonth=value!;
                      selectedMonthNumber= monthList.firstWhere((month) => month['name']==selectedMonth)['number'];
                    });
                  },
                  items: monthList.map<DropdownMenuItem<String>>((Map<String,dynamic> month){
                    return DropdownMenuItem(
                        value: month['name'],
                        child: Text(month['name'])
                    );
                  }).toList(),
                ),
              ),
            ),
            FutureBuilder(
              future: Provider.of<ExpenseProvider>(context).monthExpenses(selectedMonthNumber),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Loading state
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Error state
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ExpensePieChart(monthNumber: selectedMonthNumber, totalMonthExpense: snapshot.data!,),
                  );
                } else {
                  return const Center(child: Text('No data available')); // Handle cases with no data
                }
              },
            ),
          ],
        )
      );
  }
}

