import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yoapp/widgets/expense%20list/expenses_list.dart';
import 'package:yoapp/widgets/expense_class.dart';
import 'package:yoapp/widgets/new_expense.dart';
import 'package:yoapp/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<new_expense> _registeredExpenses = [];

  // void _addExpense() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (ctx) {
  //         return Scaffold(
  //             body: SingleChildScrollView(
  //           child: NewExpense(onAddExpense: addExpense),
  //           physics: AlwaysScrollableScrollPhysics(),
  //         ));
  //       });
  // }
  void _addExpense() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'New Expense',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: NewExpense(onAddExpense: addExpense),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addExpense(new_expense Expense) {
    setState(() {
      _registeredExpenses.add(Expense);
    });
  }

  void deleteExpense(new_expense Expense) {
    final ExpenseIndex = _registeredExpenses.indexOf(Expense);
    setState(() {
      _registeredExpenses.remove(Expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(ExpenseIndex, Expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expenses added yet"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: deleteExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addExpense();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
