// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TabItems extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItems({
    required this.label,
    required this.isSelected,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    final underline = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 4,
      width: isSelected ? 80 : 0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
    );
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          Text(label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isSelected ?Colors.greenAccent : Colors.white
          ),
          ),

          SizedBox(height: 6),
          underline
        ],
      ),
    );
  }
}
