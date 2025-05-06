import 'package:finova/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finova/views/Auth_view/screen/create_pin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';

class CodeAuthScreen extends ConsumerStatefulWidget {
  const CodeAuthScreen ({super.key});

  @override
  ConsumerState<CodeAuthScreen> createState() => _CodeAuthScreenState();
}
class _CodeAuthScreenState extends ConsumerState<CodeAuthScreen> {

   String otpCode = '';

  //.....
  void verifyOTP(BuildContext context) async {
    final verificationId = ref.read(verificationIdProvider);
    // Assuming otpCode is a 4-digit code entered by the user 
    if (verificationId == null || otpCode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect OTP or verificationId")),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      
      // Navigate only on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePinScreen(phoneNumber: ''),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification failed: ${e.toString()}")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    final verificationIdProvider = StateProvider<String?>((ref) => null);



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
                    icon: Icon(IconsaxPlusLinear.arrow_left_1 ,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
        
                  IconButton(
                    onPressed: () {
                      
                    },
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

              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Text(
                  "Enter code sent to you...",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.greenAccent),
                  ),
                ),
                onCompleted: (pin) {
                   otpCode = pin;
                },
                keyboardType: TextInputType.numberWithOptions(),
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 22, height: 2, color: Colors.greenAccent),

                   
                  ],
                ),
              ),

               Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 130,
                        //   vertical: 20,
                        // ),
                        elevation: 0,
                      ),
                      onPressed: () {
                       verifyOTP(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 100,
                        ),
                        child: Center(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
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
