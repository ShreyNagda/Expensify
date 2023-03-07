// ignore_for_file: public_member_api_docs, sort_constructors_first
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
            
          ],
        ),
      ),
    );
  }
}
