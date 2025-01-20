import 'package:flutter/material.dart';

import 'package:expense_tracker_demo/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.saveExpense});

  final void Function(Expense expense) saveExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_titleController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Title'),
          content: const Text('Please make sure valid title'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } else if (_amountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Amount'),
          content: const Text('PLease make sure valid amount'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } else if (_selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Date'),
          content: const Text('PLease make sure valid date'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.saveExpense(
      Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        date: _selectedDate!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'Rs. ',
                    label: Text('Amount'),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No selected Date'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 1, now.month, now.day),
                        lastDate: now,
                      );
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          ///////////////////////////////////////////////////////////////////////////////
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium,
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                  //Navigator.pop(context);
                },
                child: const Text('Save'),
              )
            ],
          )
          /////////////////////////////////////////////////////////////////////////////////
        ],
      ),
    );
  }
}
