import 'package:finova/logic/view_models/auth_state.dart';
import 'package:finova/providers/auth_logic_provider.dart';
import 'package:finova/views/Auth_view/screen/login_pinAuth_screen.dart';
import 'package:finova/views/Auth_view/screen/otp_auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finova/views/Auth_view/screen/create_acct_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendLoginOtp() {
    if (_formKey.currentState!.validate()) {
      // IMPORTANT: Add your country code. Firebase expects E.164 format.
      final phoneNumberWithCountryCode = "+1${_phoneController.text.trim()}"; // Example: +1 for US
      // final phoneNumberWithCountryCode = "+91${_phoneController.text.trim()}"; // Example: +91 for India

      ref.read(authLogicProvider.notifier).sendOtp(
        phoneNumber: phoneNumberWithCountryCode,
        onCodeSent: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP Sent for login!')),
          ); Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpAuthScreen(
                phoneNumber: phoneNumberWithCountryCode,
                isRegistering: false, // Indicate this is for login flow
                // No enteredPinForLogin needed here, PIN will be asked on next screen
              ),
            ),
          );
        },
        onError: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $message'), backgroundColor: Colors.red),
          );
      
        },
      
        onAutoRetrival: (userCredential) {
          // OTP Auto-retrieved, Firebase sign-in complete.
          // Navigate directly to PIN entry screen.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP Auto-retrieved! Please enter your PIN.')),
          );
      
          Navigator.pushReplacement( // Use pushReplacement to avoid back to OTP screen
            context,
            MaterialPageRoute(
              builder: (context) => LoginPinauthScreen(
                uid: userCredential.user!.uid,
                // phoneNumber: phoneNumberWithCountryCode, // Optional: can pass if needed on PIN screen
             ),
            ),
          );
        },
      );
    }
  }





  @override
  Widget build(BuildContext context) {
     final authState = ref.watch(authLogicProvider);

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

              Text(
                "Log into your account",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),

              SizedBox(height: 20),

              IntlPhoneField(
                controller: _phoneController,
                
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
                ),
                initialCountryCode: 'NG',
                onChanged: (phone) {},
                onCountryChanged: (country) {},
                dropdownTextStyle: TextStyle(color: Colors.white),
                invalidNumberMessage: 'Enter a valid Phone number ',
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateAcctScreen()),);
                    },
                    child: Text(
                      'click here to sign up ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),

              SizedBox(height: 10),
               if (authState is AuthLoading)
                const CircularProgressIndicator()
              else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  elevation: 0,
                ),
                onPressed: _sendLoginOtp,

                child: Text(
                  'Comfirm',
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
