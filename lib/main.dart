import 'package:expense_care/pages/home_page.dart';
import 'package:expense_care/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_extension.dart';

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
          textTheme: TextTheme(
            bodySmall: TextStyle(
              fontSize: 14,
              color: TColor.grey1
            ),
            titleMedium: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
            ),
            titleSmall: const TextStyle(
                fontSize: 18,
            ),
            displayLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.black
            )
          )
        ),
        home: const HomePage(),
      ),
    );
  }
}
