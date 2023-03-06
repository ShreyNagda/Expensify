import 'package:expensify/providers/expense_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          : SafeArea(child: ListView()),
    );
  }
}
