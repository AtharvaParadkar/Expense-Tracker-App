// ignore_for_file: avoid_print

import 'dart:io';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});

  final void Function(Expense expense) onAddExpense;

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

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (mia) => CupertinoAlertDialog(
          title: const Text('Invalid Input!'),
          content: const Text('Please make sure you have entered valid data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(mia);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (mia) => AlertDialog(
          title: const Text('Invalid Input!'),
          content: const Text('Please make sure you have entered valid data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(mia);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    //* tryParse() takes string as a input and returns double
    final enteredAmount = double.tryParse(_amountController.text);
    // tryParse('Hello') => null, tryParse('11.2') => 11.2
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //* Trim() removes any white spaces
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpacing = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(13, 0.1, 13, keyboardSpacing + 20),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
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
                    ],
                  )
                else
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
                if (width >= 600)
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
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
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
                  )
                else
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
                      const SizedBox(width: 14),
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
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
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
                else
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
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
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
            ),
          ),
        ),
      );
    });
  }
}
