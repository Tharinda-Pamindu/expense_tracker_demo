import 'package:expense_tracker_demo/models/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(final List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalAmountOfCategory {
    double amount = 0;
    for (final expense in expenses) {
      amount += expense.amount;
    }
    return amount;
  }
}
