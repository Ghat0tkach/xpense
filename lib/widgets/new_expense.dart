import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yoapp/models/expenses.dart';

import 'package:flutter/material.dart';
import 'package:yoapp/widgets/expense_class.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(new_expense Expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(20, 12, 16);
    final lastDate = DateTime(2040, 12, 16);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitexpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("INVALID INPUT",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: const Text(
            "Check the format of Title , Amount and Date please",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(new_expense(_titleController.text, enteredAmount,
        _selectedDate!, _selectedCategory));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _amountController,
                decoration:
                    const InputDecoration(prefixText: '₹', labelText: "Amount"),
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text(_selectedDate == null
                        ? "No Date Chosen"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month))
                  ]))
            ],
          ),
          const SizedBox(height: 36),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value as Category;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: submitexpense,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  elevation: 5,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Color.fromARGB(255, 195, 156, 153),
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.done),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
