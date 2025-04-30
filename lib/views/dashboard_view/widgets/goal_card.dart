import 'package:flutter/material.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("Goals", style: TextStyle(color: Colors.white)),
              Spacer(),
              Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: 0.2,
                      strokeWidth: 4,
                      backgroundColor: Colors.grey.shade800,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  ),
                  const Text("20%", style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("New Bicycle", style: TextStyle(color: Colors.white)),
                  Text("1 Dec 2023", style: TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}