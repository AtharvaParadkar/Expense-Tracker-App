import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Dismissible(
        //^ ValueKey() creates a key object, which can be used as a value for this key parameter
        key: ValueKey(expenses[i]),
        onDismissed: (direction) => onRemoveExpense(expenses[i]),
        background: Container(color: const Color.fromARGB(255, 255, 0, 0)),
        secondaryBackground:
            Container(color: const Color.fromARGB(255, 0, 255, 0)),
        child: ExpenseItem(expenses[i]),
      ),
    );
  }
}
