import 'package:finova/views/Auth_view/screen/Pin_Auth_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';


class CreateAcctScreen extends StatelessWidget {
  const CreateAcctScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      IconsaxPlusLinear.arrow_left_1,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
        
                  IconButton(
                    onPressed: () {
                      
                    },
                    icon: Icon(
                    IconsaxPlusLinear.arrow_right_3, 
                    color: Colors.white,
                    size: 30,),
                  ),
                ],
              ),
        
              SizedBox(height: 40),
        
              Row(
                spacing: 10,
                children: [
                  Row(
                    spacing: 0,
                    children: [
                      CircleAvatar(radius: 18, backgroundColor: Colors.white),
                      CircleAvatar(radius: 18, backgroundColor: Colors.white),
                    ],
                  ),
        
                  Text(
                    'Planoo',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 30),
        
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Text(
                  "Let's Create an Account ",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
        
              IntlPhoneField(
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
        
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.white),
                  ),
        
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderSide: BorderSide()),
        
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
        
                  // border: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),)
                ),
                initialCountryCode: 'NG',
                onChanged: (phone) {},
                onCountryChanged: (country) {},
                dropdownTextStyle: TextStyle(color: Colors.white),
                invalidNumberMessage: 'Enter a valid Phone number ',
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PinAuthScreen()),
                  );
                },
                child: Text(
                  'Create account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
