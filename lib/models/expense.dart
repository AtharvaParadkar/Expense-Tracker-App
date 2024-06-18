import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

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
}
