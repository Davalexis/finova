import 'package:flutter/material.dart';


class AiAssistantCard extends StatelessWidget {
  const AiAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("AI Assistant", style: TextStyle(color: Colors.white)),
              Spacer(),
              Icon(Icons.messenger_outline_sharp,
               color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Get free personal finance assistant from AI powered chatbot.",
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const Spacer(),
          Row(
            children: const [
              Text(
                "Start new chat with ",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "AI",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              
            ],
          ),
        ],
      ),
    );
  }
}
