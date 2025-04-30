import 'package:finova/views/dashboard_view/widgets/action_buttons.dart';
import 'package:finova/views/dashboard_view/widgets/ai_assistant_card.dart';
import 'package:finova/views/dashboard_view/widgets/balance_card.dart';
import 'package:finova/views/dashboard_view/widgets/goal_card.dart';
import 'package:finova/views/dashboard_view/widgets/recent_transactions.dart';
import 'package:finova/views/dashboard_view/widgets/topbar_section.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopbarSection(),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    width: double.maxFinite,
                    child: BalanceCard(),
                  ),
                  SizedBox(height: 20),
                  ActionButtons(),
                  SizedBox(height: 20),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(child: GoalsCard()),
                      Expanded(child: AiAssistantCard()),
                    ],
                  ),
                  SizedBox(height: 20),
                  //  ExpenseSummary
                  RecentTransactions() 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
