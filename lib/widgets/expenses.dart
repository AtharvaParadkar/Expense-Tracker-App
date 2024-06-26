import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';

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

//^ Using our coustom class Expense as a type
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    //* Gives the index of the removed expense to restore it again
    final expenseIndex = _registeredExpense.indexOf(expense);

    setState(() {
      _registeredExpense.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        backgroundColor: Colors.red,
        shape: const StadiumBorder(),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      //? A safe area is a simple built in flutter feature that makes sure that we stay away from device features like camera that are affecting our UI
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      //~ ctx is the context object for the modal element that's created by flutter
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses Found, Start adding some!'),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      //? The property resizeToAvoidBottomInset prevents the chart from resizing, when kept false, when the keyboard is displayed.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('Expense Tracker'),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpense),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                //& Expanded constraints the child to only take as much width as available in the rowafter sizing the other row children
                Expanded(child: Chart(expenses: _registeredExpense)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
