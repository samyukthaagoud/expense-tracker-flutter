import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String selectedCategory = "Food";

  void saveExpense() {
    if (amountController.text.isEmpty) return;

    Expense expense = Expense(
      category: selectedCategory,
      amount: double.parse(amountController.text),
      date: dateController.text,
    );

    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Food", child: Text("Food")),
                DropdownMenuItem(value: "Travel", child: Text("Travel")),
                DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
                DropdownMenuItem(value: "Bills", child: Text("Bills")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveExpense,
              child: const Text("Save Expense"),
            ),
          ],
        ),
      ),
    );
  }
}