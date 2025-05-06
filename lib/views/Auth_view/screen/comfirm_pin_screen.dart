import 'package:finova/providers/auth_provider.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';


class  ComfirmPinScreen extends ConsumerWidget {
  final String phoneNumber;
  final String pin;
  const ComfirmPinScreen ({
    super.key, 
    required this.phoneNumber, 
    required this.pin
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

     final comfirmPinController = ref.watch(pinControllerProvider);
     final pinNotifier = ref.watch(pinControllerProvider);


    final defaultPinTheme = PinTheme(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(13),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.headset_mic_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
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
                    'Finova',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Padding(
              //   padding: const EdgeInsets.only(right: 110),
              //   child: 
               Text(
                   "Comfirm pin entered \nearlier",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              
              SizedBox(height: 20),

              Pinput(
                controller: comfirmPinController,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.greenAccent),
                  ),
                ),
                onCompleted: (enteredPin) {
                  if (enteredPin == pin) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pin does not match.')),
                    );
                    pinNotifier.clear();
                  }

              
                },
                keyboardType: TextInputType.numberWithOptions(),
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 22, height: 2, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Pinput(
              //   length: 4,
              //   defaultPinTheme: defaultPinTheme,
              //   focusedPinTheme: defaultPinTheme.copyWith(
              //     decoration: defaultPinTheme.decoration!.copyWith(
              //       border: Border.all(color: Colors.greenAccent),
              //     ),
              //   ),
              //   onCompleted: (pin) {},
              //   keyboardType: TextInputType.numberWithOptions(),
              //   cursor: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Container(width: 22, height: 2, color: Colors.white),
              //     ],
              //   ),
              // ),
              Spacer(),

              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),);
                },

                child: Center(
                  child: Text(
                    'Done ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
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
