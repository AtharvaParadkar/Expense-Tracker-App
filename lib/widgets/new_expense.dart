import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  var _enteredTitle = '';
  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: _saveTitleInput, //* To store the value
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(_enteredTitle);
                  },
                  child: const Text('Save Expense'),
                ),
              ],
            )
          ],
        ));
  }
}
