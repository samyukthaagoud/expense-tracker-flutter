import 'package:flutter/material.dart';
import 'screens/add_expense_screen.dart';
import 'models/expense.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
double income = 0;
TextEditingController incomeController =
    TextEditingController();
  List<Expense> expenses = [];

  double get totalExpense {
    double total = 0;

    for (var expense in expenses) {
      total += expense.amount;
    }

    return total;
  }

  double get balance {
    return income - totalExpense;
  }

  Future<void> addExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpenseScreen(),
      ),
    );

    if (result != null && result is Expense) {
      setState(() {
        expenses.add(result);
      });
    }
  }

  IconData getIcon(String category) {
    switch (category) {
      case "Food":
        return Icons.fastfood;
      case "Travel":
        return Icons.directions_bus;
      case "Shopping":
        return Icons.shopping_cart;
      case "Bills":
        return Icons.receipt;
      default:
        return Icons.money;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Available Balance",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "₹${balance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          if (income == 0) ...[
  TextField(
    controller: incomeController,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
      labelText: "Enter Monthly Income",
      border: OutlineInputBorder(),
    ),
  ),

  const SizedBox(height: 10),

  ElevatedButton(
    onPressed: () {
      setState(() {
        income =
            double.tryParse(
              incomeController.text,
            ) ??
            0;
      });

      incomeController.clear();
    },
    child: const Text("Save Income"),
  ),

  const SizedBox(height: 20),
],
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                Column(
  children: [
    const Text("Income"),
    TextButton(
      onPressed: () {
        setState(() {
          income = 0;
        });
      },
      child: const Text("Edit"),
    ),
                    Text(
                      "₹${income.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Expense"),
                    Text(
                      "₹${totalExpense.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: addExpense,
              icon: const Icon(Icons.add),
              label: const Text("Add Expense"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Recent Expenses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: expenses.isEmpty
                  ? const Center(
                      child: Text(
                        "No expenses added yet",
                      ),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];

                        return Card(
  child: ListTile(
    leading: Icon(
      getIcon(expense.category),
    ),
    title: Text(expense.category),
    subtitle: Text(expense.date),
   trailing: SizedBox(
  width: 110,
  child: Row(
    children: [
      Text("₹${expense.amount}"),
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            expenses.removeAt(index);
          });
        },
      ),
    ],
  ),
),
  ),
);
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}