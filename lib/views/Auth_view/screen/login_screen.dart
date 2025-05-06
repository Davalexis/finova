import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finova/providers/auth_provider.dart';
import 'package:finova/views/Auth_view/screen/create_acct_screen.dart';
// import 'package:finova/views/Auth_view/screen/login_pinAuth_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final phoneController = ref.watch(phoneControllerProvider);
    final loginViewModel = ref.watch(loginViewModelProvider.notifier);
    final loginState = ref.watch(loginViewModelProvider);

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
                controller: phoneController,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAcctScreen(),
                        ),
                      );
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  elevation: 0,
                ),
                onPressed:
                    loginState.isLoading
                        ? null
                        : () {
                          final phone = phoneController.text.trim();
                          loginViewModel.submitPhone(phone, ref, context);
                        },

                child:
                    loginState.isLoading
                        ? CircularProgressIndicator()
                        : Center(
                          child: Text(
                            'Comfirm',
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
