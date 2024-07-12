
import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path ;
import 'package:provider/provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class Expenses extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get categoryImageUrl => text()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime()();
}

@DriftDatabase(tables: [Expenses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Expense>> getAllExpenses() async {
    return await select(expenses).get();
  }

  Future insertExpense(ExpensesCompanion entity) async {
    return await into(expenses).insert(entity);
  }

  Future updateExpense(ExpensesCompanion entity) async {
    return await update(expenses).replace(entity);
  }

  Future deleteExpense(Expense entity) async {
    return await delete(expenses).delete(entity);
  }

  Future<double> totalExpenses() async {
    final total = expenses.amount.sum();
    final query= selectOnly(expenses)..addColumns([total]);
    return await query.map((row) => row.read(total) ?? 0.0).getSingle();
  }

  Future<double> todayExpenses() async {
    final now = DateTime.now();
    final startOfDay= DateTime(now.year,now.month,now.day);
    final endOfDay= DateTime(now.year,now.month,now.day, 23, 59, 59);

    final total = expenses.amount.sum();
    final query= selectOnly(expenses)..addColumns([total])..where(expenses.date.isBetweenValues(startOfDay, endOfDay));
    return query.map((r) => r.read(total) ?? 0.0).getSingle();
  }

  Future<double> totalMonthExpenses() async {
    final now = DateTime.now();
    final firstDayMonth = DateTime(now.year, now.month, 1);
    final lastDayMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final total = expenses.amount.sum();
    final query = selectOnly(expenses)
      ..addColumns([total])
      ..where(expenses.date.isBetweenValues(firstDayMonth, lastDayMonth));

    return await query.map((row) => row.read(total) ?? 0.0).getSingle();
  }

  Future<double> monthExpenses(int monthNumber) async{
    final now = DateTime.now();

    final total = expenses.amount.sum();
    final query = selectOnly(expenses)
      ..addColumns([total])
      ..where(expenses.date.month.equals(monthNumber) & expenses.date.year.equals(now.year));

    return await query.map((row) => row.read(total) ?? 0.0).getSingle();
  }

  Future<double> monthlyCategoryExpenses(int monthNumber, String category) async{
    final now = DateTime.now();

    final total = expenses.amount.sum();
    final query = selectOnly(expenses)
      ..addColumns([total])
      ..where(expenses.date.month.equals(monthNumber) & expenses.date.year.equals(now.year) & expenses.category.equals(category));

    return await query.map((row) => row.read(total) ?? 0.0).getSingle();
  }
}




LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase(file);
  });
}
