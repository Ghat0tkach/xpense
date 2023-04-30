import 'package:flutter/material.dart';
import 'package:Xpense/widgets/expense%20list/expense_item.dart';
import 'package:Xpense/widgets/expense_class.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(new_expense Expense) onRemoveExpense;
  final List<new_expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
              onDismissed: (
                direction,
              ) {
                onRemoveExpense(expenses[index]);
              },
              key: ValueKey(expenses[index].id),
              background: Container(
                color: Theme.of(context).colorScheme.error,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              child: ExpenseItem(expenses[index]));
        });
  }
}
//     return Column(
//       children: [
//         Container(
//           height: 300,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return Card(
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Theme.of(context).primaryColor,
//                           width: 2,
//                         ),
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         "\$${expenses[index].amount.toStringAsFixed(2)}",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           expenses[index].title,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           expenses[index].date.toString(),
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//             itemCount: expenses.length,
//           ),
//         ),
//       ],
//     );
//   }
// }
