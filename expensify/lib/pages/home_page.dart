import 'package:expensify/pages/add_expense.dart';
import 'package:expensify/providers/expense_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ExpenseNotifier expenseNotifier = Provider.of<ExpenseNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expensify'),
        centerTitle: true,
      ),
      body: expenseNotifier.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: expenseNotifier.expenses.length,
                  itemBuilder: (context, index) {
                    Expense currentExpense = expenseNotifier.expenses[index];
                    return GestureDetector(
                      onTap: () {
                        print(index);
                      },
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Center(child: Icon(Icons.currency_rupee)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentExpense.amount.toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(currentExpense.description ??
                                          currentExpense.category!)
                                    ]),
                              ),
                              Text(format(currentExpense.date!))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (_) => const AddExpense(
                  isUpdate: false,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String format(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}';
  }
}
