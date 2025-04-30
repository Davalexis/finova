import 'package:finova/views/dashboard_view/widgets/expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Balance', style: TextStyle(color: Colors.white70)),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: Row(
                        spacing: 6,
                        children: [
                          Text(
                            "Add money",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(LucideIcons.plus400, color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "₦ 4,348,000.00",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                // ExpenseSummary()
              ],
            ),

            Spacer(),

            ExpenseSummary()
          ],
        ),
      ),
    );
  }
}
