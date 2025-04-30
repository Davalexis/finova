import 'package:flutter/material.dart';
import  'package:lucide_icons_flutter/lucide_icons.dart';



class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {},
            child: Row(
              children: [
                Icon( LucideIcons.arrowUpRight400, color: Colors.black,size: 20,),
                SizedBox(width: 20),
                Text(
                  "Send",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 20),

       SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1C1C1E),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Icon( LucideIcons.arrowDownLeft400, color: Colors.white,size: 20,),
                SizedBox(width: 20),
                Text(
                  "Recieved",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),

        CircleAvatar(
          backgroundColor:Color(0xFF1C1C1E),
          child:  Icon(Icons.qr_code, color: Colors.white,)),
      ],
    );
  }
}
