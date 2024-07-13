import 'package:expense_care/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../color_extension.dart';
import '../pages/all_transaction.dart';
import '../pages/new_expense.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex=0;
  List pages= const[HomePage(), NewExpense(), AllTransaction()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.black4,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: TColor.peach1,
              blurRadius: 8,
              // offset: const Offset(0,5)
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            backgroundColor: TColor.black1,
            selectedItemColor: TColor.peach2,
            unselectedItemColor: TColor.peach,
            selectedIconTheme: const IconThemeData(size: 30),
            unselectedIconTheme: const IconThemeData( size: 23 ),
            selectedFontSize: 15,
            onTap: (index){
              setState(() {
                selectedIndex= index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: 'Add'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card),
                  label: 'Transactions'
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
