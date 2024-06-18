import "package:expense_tracker_app/widgets/expenses.dart";
import "package:flutter/material.dart";

void main() {
  runApp(
    MaterialApp(
      home: const Expenses(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    ),
  );
}
