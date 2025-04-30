// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// RECENT TRANSACTION BLUEPRINT

class TransactionListTile extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  final String amount;

  const TransactionListTile({
    super.key,

    required this.name,
    required this.date,
    required this.amount,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // PROPERTIES OF THE RECENT TRANSACTIONS

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF1C1C1E),
            child: Icon(
              LucideIcons.tvMinimalPlay400,
              color: Colors.greenAccent,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white)),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// LIST OF THR RECENT TRANSACTION

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [

        Padding(
          padding: const EdgeInsets.only(right: 200),
          child: Text('Recent transaction',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            ),
        ),

        SizedBox(height: 10,),
        TransactionListTile(
          image:
              'https://images.unsplash.com/photo-1614680376593-902f74cf0d41?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: 'Spotify',
          date: '30-01-2022',
          amount: "₦2,000",
        ),

        TransactionListTile(
          image:
              'https://images.unsplash.com/photo-1611162616475-46b635cb6868?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8eW91dHViZSUyMGxvZ298ZW58MHx8MHx8fDA%3D',
          name: 'Youtube',
          date: '27-01-2022',
          amount: '₦${2400}',
        ),

        TransactionListTile(
          image:
              'https://images.unsplash.com/photo-1662338035252-74cdac76bd2a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bmV0ZmxpeCUyMGxvZ298ZW58MHx8MHx8fDA%3D',
          name: 'Netflix',
          date: '25-18-2022',
          amount: '₦${4000}',
        ),
      ],
    );
  }
}
