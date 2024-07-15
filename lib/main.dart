import 'package:expense_care/providers/expense_provider.dart';
import 'package:expense_care/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ExpenseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false ,
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.black
            )
          )
        ),
        home: const BottomNavBar(),
      ),
    );
  }
}

