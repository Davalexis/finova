import 'package:finova/data/model/user_model.dart';
import 'package:finova/logic/view_models/auth_state.dart';
import 'package:finova/providers/auth_logic_provider.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';

class LoginPinauthScreen extends ConsumerStatefulWidget {
  final String uid;
  const LoginPinauthScreen({required this.uid, super.key});

  @override
  ConsumerState<LoginPinauthScreen> createState() => _LoginPinauthScreenState();
}

class _LoginPinauthScreenState extends ConsumerState<LoginPinauthScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verifyPinAndLogin() {
    if (_formKey.currentState!.validate()) {
      final enteredPin = _pinController.text.trim();

      ref
          .read(authLogicProvider.notifier)
          .checkPinAfterFirebaseLogin(
            uid: widget.uid,
            enterPin: enteredPin,
            onSuccess: (userModel) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Successful! Welcome back, ${userModel.phoneNumber}.',
                  ),
                ),
              );

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            onError: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login Error: $message'),
                  backgroundColor: Colors.red,
                ),
              );

              _pinController.clear();
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
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

              // Text(
              //   " ${userModel.phoneNumber}",
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.greenAccent,
              //     height: 1,
              //   ),
              // ),
              SizedBox(height: 30),

              Text(
                "Please enter your 4-digit PIN to complete login.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),

              SizedBox(height: 20),

              Pinput(
                controller: _pinController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 4) {
                    return 'PIN must be 4 digits';
                  }
                  return null;
                },

                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.greenAccent),
                  ),
                ),
                onCompleted: (pin) {},
                keyboardType: TextInputType.numberWithOptions(),
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 22, height: 2, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Spacer(),

              SizedBox(height: 10),
              const SizedBox(height: 30),
              if (AuthState is AuthLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,

                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    elevation: 0,
                  ),
                  onPressed: _verifyPinAndLogin,

                  child: Text(
                    'Comfirm ',
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
