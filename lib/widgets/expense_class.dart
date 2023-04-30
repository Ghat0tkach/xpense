import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  stationary,
  entertainment,
  other,
}

const categoryIcons = {
  Category.food: Icons.food_bank_sharp,
  Category.travel: Icons.airplanemode_active,
  Category.stationary: Icons.book,
  Category.entertainment: Icons.movie,
  Category.other: Icons.money,
};

class new_expense {
  new_expense(this.title, this.amount, this.date, this.category)
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.forCategory(List<new_expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<new_expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
