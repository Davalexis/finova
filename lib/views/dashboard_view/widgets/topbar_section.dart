import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TopbarSection extends StatelessWidget {
  const TopbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF1C1C1E),
          backgroundImage: AssetImage('assets/images/image1.jpg'),
        ),

        Spacer(),

        CircleAvatar(
          backgroundColor: Color(0xFF1C1C1E),
          child: Icon(LucideIcons.bell400, color: Colors.white),
        ),

        SizedBox(width: 5),

        CircleAvatar(
          backgroundColor: Color(0xFF1C1C1E),
          child: Icon(LucideIcons.menu400, color: Colors.white),
        ),
      ],
    );
  }
}
