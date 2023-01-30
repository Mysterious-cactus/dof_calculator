import 'package:dof_calculator/ui/roots/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.deepPurple[100],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          focusColor: Colors.deepPurple[900],
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          fillColor: Colors.deepPurple[50],
          filled: true,
          //floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        primarySwatch: Colors.deepPurple,
        primaryTextTheme: TextTheme(
          titleMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.deepPurple[900],
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[800],
            actionsIconTheme: const IconThemeData(color: Colors.white)),
        focusColor: Colors.white,
        //colorScheme:
        //    ColorScheme.fromSwatch().copyWith(primary: Colors.grey[600]),
        primarySwatch: Colors.grey,
        canvasColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            fillColor: Colors.grey[800],
            filled: true,
            //floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.always),
        primaryTextTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Home.create(),
    );
  }
}
