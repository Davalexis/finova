import 'package:finova/logic/view_models/auth_state.dart';
import 'package:finova/providers/auth_logic_provider.dart';
import 'package:finova/views/Auth_view/screen/create_pin_Screen.dart';
import 'package:finova/views/Auth_view/screen/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finova/views/Auth_view/screen/otp_auth_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CreateAcctScreen extends ConsumerStatefulWidget {
  const CreateAcctScreen({super.key});

  @override
  ConsumerState<CreateAcctScreen> createState() => _CreateAcctScreenState();
}

class _CreateAcctScreenState extends ConsumerState<CreateAcctScreen> {
  
  //?
  final _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //?
  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  //
  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      final phoneNumberWithCountryCode = "+234${_phoneNumber.text.trim()}";

      ref
          .read(authLogicProvider.notifier)
          .sendOtp(
            phoneNumber: phoneNumberWithCountryCode,
            //
            onCodeSent: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('OTP Sent')));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => OtpAuthScreen(
                        phoneNumber: phoneNumberWithCountryCode,
                        isRegistering: true,
                      ),
                ),
              );
            },
            //
            onError: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $message')));
            },
            //
            onAutoRetrival: (UserCredential) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('OTP auto-retrieved')));

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CreatePinScreen(
                        phoneNumber: phoneNumberWithCountryCode,
                        uid: UserCredential.user!.uid,
                      ),
                ),
              );
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authLogicProvider, (previous, next) {
      if (next is AuthError && ModalRoute.of(context)?.isCurrent == true) {}
    });

    final AuthState = ref.watch(authLogicProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.headset_mic_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
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
                key: _formKey,
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

              SizedBox(height: 10),
              Row(
                children: [
                  Text("Already have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),

              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  elevation: 0,
                ),
                onPressed: _sendOtp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 100,
                  ),
                  child: Center(
                    child: Text(
                      'Create account',
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
