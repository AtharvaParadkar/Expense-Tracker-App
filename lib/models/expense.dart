import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.dinner_dining_outlined,
  Category.travel: Icons.flight_takeoff_sharp,
  Category.leisure: Icons.movie_sharp,
  Category.work: Icons.work_outline_rounded,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  //^ ': id = uuid.v4();' this initializer list is a dart feature that can be used to initialize class properties (like 'id') with values thar are NOT recevied as constructor funtion arguments.

  final String id, title;
  final double amount;
  final DateTime date;
  final Category category;

  //& 'Getters' are basically 'computed properties' => properties that are dynamically derived, based on other class properties.
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  //& Utility Constructor Function
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  //? The colon (:) introduces the initializer list.
  //? the 'where' is is simply a method that allows you to filter a list.

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    //^ for in Loop
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
