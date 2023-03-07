// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_time_picker/date_time_picker.dart';
import 'package:expensify/constants.dart';
import 'package:expensify/providers/expense_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
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
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode categoryFocus = FocusNode();

  int selectedIndex = 0;
  TextStyle style = const TextStyle(
    fontSize: 18,
  );

  DateTime firstDate = DateTime(DateTime.now().year - 10);
  DateTime lastDate = DateTime(DateTime.now().year + 10);

  DateTime date = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Intl.defaultLocale = 'en_In';
    super.initState();
    categoryController.text = categories[selectedIndex];
    categoryFocus.canRequestFocus = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Expense expense = Expense(
                  id: const Uuid().v1(),
                  userid: 'shreynagda',
                  amount: double.tryParse(amountController.text.toString()),
                  description: descriptionController.text != ""
                      ? descriptionController.text
                      : categoryController.text,
                  category: categoryController.text,
                  date: date,
                );
                Provider.of<ExpenseNotifier>(context, listen: false).addExpense(expense);
              }
              print(format.format(date));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                autofocus: true,
                controller: amountController,
                style: style,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  prefixIcon: Icon(
                    Icons.currency_rupee_rounded,
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (value) {
                  if (value!.isEmpty || double.parse(value) <= 0) {
                    return 'Enter amount';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: descriptionController,
                style: style,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  prefixIcon: Icon(
                    Icons.description,
                  ),
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              DateTimePicker(
                dateMask: format.pattern,
                locale: const Locale('en', 'US'),
                use24HourFormat: false,
                onChanged: (String? value) {
                  setState(() {
                    date = DateTime.tryParse(value!)!;
                  });
                },
                type: DateTimePickerType.dateTime,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_rounded)),
                firstDate: firstDate,
                lastDate: lastDate,
                initialValue: format.format(DateTime.now()),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                style: style,
                // onTap: () {},
                readOnly: true,
                focusNode: categoryFocus,
                controller: categoryController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.style_rounded,
                  ),
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              categoryController.text =
                                  categories[selectedIndex];
                            });
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: BorderSide(
                                  color: selectedIndex == index
                                      ? Colors.blue
                                      : Theme.of(context).cardColor,
                                  width: 2),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(icons[index]),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      categories[index],
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
