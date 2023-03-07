import 'dart:convert';

import '../models/expense.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseURL = "https://expensify-o42m.onrender.com/expenses";

  static Future<void> addExpense(Expense expense) async {
    Uri uri = Uri.parse('$baseURL/add');
    var response = await http.post(uri, body: expense.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
  }

  static Future<void> deleteExpense(Expense expense) async {
    Uri uri = Uri.parse('$baseURL/delete');
    var response = await http.post(uri, body: expense.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
  }

  static Future<List<Expense>> fetchExpenses(String userid) async {
    Uri uri = Uri.parse('$baseURL/list');
    var response = await http.post(uri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    print(decoded);
    List<Expense> expenses = [];
    for (var expenseMap in decoded) {
      Expense expense = Expense.fromMap(expenseMap);
      expenses.add(expense);
    }
    return expenses;
  }
}
