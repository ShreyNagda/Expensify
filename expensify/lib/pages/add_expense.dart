// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expensify/constants.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class AddExpense extends StatefulWidget {
  final bool isUpdate;
  final Expense? expense;
  const AddExpense({
    Key? key,
    required this.isUpdate,
    this.expense,
  }) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String category = '';

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = categories[selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(),
            TextFormField(),
            TextFormField(),
            SizedBox(
                width: double.infinity,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(children: [
                          const Icon(Icons.fastfood_rounded),
                          Text(categories[index])
                        ]),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
