import 'package:flutter/material.dart';

class ExpenseList extends ChangeNotifier{
  final List<Map<String,dynamic>> expenses =[];

  void addExpense(Map<String,dynamic> expense){
    expenses.add(expense);
    notifyListeners();
  }
  void deleteExpense(Map<String,dynamic> expense){
    expenses.remove(expense);
    notifyListeners();
  }

}