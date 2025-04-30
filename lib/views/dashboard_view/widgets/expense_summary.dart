import 'package:flutter/material.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildExpenseCard("Today's Expense", "₦1,247", "+1.4%"),
        const SizedBox(width: 12),
        _buildExpenseCard("Weekly Expense", "₦ 3,214", "+2.8%"),
      ],
    );
  }

  Widget _buildExpenseCard(String title, String amount, String percent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- $amount", style: const TextStyle(color: Colors.white, fontSize: 18)),
                Text(percent, style: const TextStyle(color: Colors.greenAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
