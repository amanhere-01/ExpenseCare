import 'package:expense_care/database/database.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier{
  final AppDatabase _database = AppDatabase();
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider(){
    _loadExpenses();
  }

  Future<void>  _loadExpenses()  async{
    _expenses = await _database.getAllExpenses();
    notifyListeners();
  }

  Future<void> addExpense(ExpensesCompanion expense) async{
    await _database.insertExpense(expense);
    await _loadExpenses();
  }

  Future<void> deleteExpense(Expense expense) async{
    await _database.deleteExpense(expense);
    await _loadExpenses();
  }

  Future<void> updateExpense(ExpensesCompanion expense) async{
    await _database.updateExpense(expense);
    await _loadExpenses();
  }

  Future<double> totalExpenses() async{
    return await _database.totalExpenses();
  }

  Future<double> todayExpenses() async{
    return await _database.todayExpenses();
  }

  Future<double> totalMonthExpenses() async{
    return await _database.totalMonthExpenses();
  }

  Future<double> monthExpenses(int monthNumber) async{
    return await _database.monthExpenses(monthNumber);
  }
  Future<double> monthlyCategoryExpenses(int monthNumber, String category) async{
    return await _database.monthlyCategoryExpenses(monthNumber,category);
  }


}