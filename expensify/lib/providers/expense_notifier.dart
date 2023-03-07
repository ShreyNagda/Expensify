import 'package:expensify/Services/api_services.dart';
import 'package:expensify/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier extends ChangeNotifier {
  List<Expense> expenses = [];
  bool isLoading = true;

  ExpenseNotifier() {
    fetchExpenses();
  }

  void sortExpenses() {
    expenses.sort((a, b) => b.date!.compareTo(a.date!));
  }

  void addExpense(Expense expense) {
    expenses.add(expense);
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    int expenseIndex = expenses
        .indexOf(expenses.firstWhere((element) => element.id == expense.id));

    expenses[expenseIndex] = expense;
    notifyListeners();
  }

  void deleteExpense(Expense expense) {
    int expenseIndex = expenses
        .indexOf(expenses.firstWhere((element) => element.id == expense.id));

    expenses.removeAt(expenseIndex);
    notifyListeners();
  }

  void fetchExpenses() async {
    expenses = await ApiService.fetchExpenses('shreynagda');
    isLoading = false;
    notifyListeners();
  }

  List<Expense> getFilteredExpenses(String searchQuery) {
    return expenses
        .where((element) =>
            element.description!.toLowerCase().contains(searchQuery) ||
            element.amount == double.parse(searchQuery) ||
            element.category!.toLowerCase().contains(searchQuery))
        .toList();
  }
}
