import 'package:finova/logic/view_models/auth_state.dart';
import 'package:finova/providers/auth_logic_provider.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';

class ComfirmPinScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String firstpin;
  final String uid;
  const ComfirmPinScreen({
    super.key,
    required this.phoneNumber,
    required this.firstpin,
    required this.uid,
  });

  @override
  ConsumerState<ComfirmPinScreen> createState() => _ComfirmPinScreenState();
}

class _ComfirmPinScreenState extends ConsumerState<ComfirmPinScreen> {
  final _confirmPinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _confirmPinController.dispose();
    super.dispose();
  }

  void _createAccountAndSetPin() {
    if (_formKey.currentState!.validate()) {
      if (_confirmPinController.text.trim() == widget.firstpin) {
        ref
            .read(authLogicProvider.notifier)
            .createAccountWithPin(
              pin: widget.firstpin,
              phoneNumber: widget.phoneNumber,
              uid: widget.uid,
              onSuccess: (userModel) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Account created for ${userModel.phoneNumber}!',
                    ),
                  ),
                );
                // Navigate to home screen, clearing the auth stack
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
                    content: Text('Error: $message'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PINs do not match. Please try again.')),
        );
        _confirmPinController.clear(); // Clear the field for re-entry
      }
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

              // Padding(
              //   padding: const EdgeInsets.only(right: 110),
              //   child:
              Text(
                "Re-enter your 4-digit PIN to confirm.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),

              SizedBox(height: 20),

              Pinput(
                length: 4,
                controller: _confirmPinController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 4) {
                    return 'PIN must be 4 digits';
                  }
                  return null;
                },

                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.greenAccent),
                  ),
                ),
                onCompleted: (enteredPin) {},
                keyboardType: TextInputType.numberWithOptions(),
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 22, height: 2, color: Colors.greenAccent),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Spacer(),

              SizedBox(height: 10),

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
                  onPressed: _createAccountAndSetPin,

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
