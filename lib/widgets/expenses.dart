import 'package:flutter/material.dart';

import 'package:expense_tracker_demo/chart/chart.dart';
import 'package:expense_tracker_demo/widgets/expense_list.dart';
import 'package:expense_tracker_demo/widgets/new_expense.dart';
import 'package:expense_tracker_demo/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];
  // [
  //   Expense(
  //     title: 'Udemy',
  //     amount: 1500,
  //     category: Category.work,
  //     date: DateTime.now(),
  //   ),
  //   Expense(
  //     title: 'Go to home',
  //     amount: 200,
  //     category: Category.travel,
  //     date: DateTime(2024, 8, 1),
  //   ),
  //   Expense(
  //     title: 'Dinner',
  //     amount: 750,
  //     category: Category.food,
  //     date: DateTime(2023, 9, 21),
  //   ),
  // ];

  void _addNewExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        saveExpense: _save,
      ),
    );
  }

  void _save(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _revomeExpense(Expense expense) {
    final indexOfExpense = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    //clear all scaffold messages
    ScaffoldMessenger.of(context).clearSnackBars();

    //pop up new Message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () {
              _registeredExpenses.insert(indexOfExpense, expense);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget mainContent = _registeredExpenses.isNotEmpty
        ? ExpenseList(
            expenses: _registeredExpenses,
            remove: _revomeExpense,
          )
        : Center(
            child: Text(
              'No expenses added yet',
              style: TextStyle(
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _addNewExpense,
            icon: const Icon(Icons.add_box_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Chart(expenses: _registeredExpenses),
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
