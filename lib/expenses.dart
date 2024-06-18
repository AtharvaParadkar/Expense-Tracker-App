import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  
  final List<Expense> _registeredExpense = [
    Expense(
      title: 'Flutter Course',
      amount: 1500,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 850,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 255),
      ),
      body: const Column(
        children: [Text('The Chart'), Text('Expenses List....')],
      ),
    );
  }
}
