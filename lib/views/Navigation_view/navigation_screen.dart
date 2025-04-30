import 'package:finova/views/Navigation_view/custom_tabbar.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:finova/views/data_plan_view/screen/Data_plan_screen.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String currentTab = "Dashboard";

  Widget get currentScreen {
    switch (currentTab) {
      case "Data Plans":
        return const DataPlanScreen();
      case "Dashboard":
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: CustomBottomNavBar(
        selectedTab: currentTab,
        onTabChanged: (tab) {
          setState(() {
            currentTab = tab;
          });
        },
      ),
    );
  }
}