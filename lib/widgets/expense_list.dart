import 'package:flutter/material.dart';

import 'package:expense_tracker_demo/widgets/expense_item.dart';
import 'package:expense_tracker_demo/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.remove});

  final List<Expense> expenses;
  final void Function(Expense expense) remove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error,
          padding: Theme.of(context)
              .cardTheme
              .margin, ////change padding using padding
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        onDismissed: (direction) {
          remove(expenses[index]);
        },
        direction: DismissDirection.endToStart,
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
