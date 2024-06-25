// ignore_for_file: avoid_print

import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //* There are 2 ways to store the value

  //& 1 way
  //& var _enteredTitle = '';
  //& void _saveTitleInput(String inputValue) {
  //&   _enteredTitle = inputValue;
  //& }

  //~ 2 way
  final _titleController = TextEditingController(),
      _amountController = TextEditingController();
  //^ When you create the TextEditingController tell flutter to delete thet controller when widget is not needed anymore
  @override
  void dispose() {
    //? Only stateful widget can implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // Dispose like 'initState' and 'build' is part of statful widgets lifecycle. Its called automatically by flutter when the widget & its state are about to be destroyed(removed from UI).

  Category _selectedCategory = Category.travel;

  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now(),
        firstDate = DateTime(now.year - 2, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      // initialDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              //& 1 Way
              //& onChanged: _saveTitleInput,
              //~ 2 way
              controller: _titleController,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\u{20B9} ',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Data Selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                DropdownButton(
                  //^ DropDown Button does't suppor controller
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if(value==null){
                      return;
                    }
                    setState(() {
                      _selectedCategory=value;
                    });
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_amountController.text);
                  },
                  child: const Text('Save Expense'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            )
          ],
        ));
  }
}
