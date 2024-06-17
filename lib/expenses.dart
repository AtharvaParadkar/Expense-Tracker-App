import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 255),
      ),
      body: const Column(
        children: [
          Text('The Chart'),
          Text('Expenses List....')
        ],
      ),
    );
  }
}