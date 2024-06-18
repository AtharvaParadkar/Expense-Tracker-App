import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromARGB(255, 0, 255, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\u{20B9}${expense.amount.toStringAsFixed(2)}'),
                //^ Spacer will take all the remaining space left by the text and row widget. Hence the text will go in the left and row in the right
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(expense.category.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
