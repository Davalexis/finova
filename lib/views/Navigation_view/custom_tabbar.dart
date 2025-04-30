import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const CustomBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Dashboard', 'Data Plans'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () => onTabChanged(tab),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tab,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.greenAccent: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 1,
                  width: isSelected ? 90 : 0,
                  color: Colors.greenAccent,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}