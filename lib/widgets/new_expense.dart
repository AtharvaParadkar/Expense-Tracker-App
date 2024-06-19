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
            TextField(
              controller: _amountController,
              maxLength: 8,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '\u{20B9} ',
                label: Text('Amount'),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_amountController.text);
                  },
                  child: const Text('Save Expense'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
              ],
            )
          ],
        ));
  }
}
