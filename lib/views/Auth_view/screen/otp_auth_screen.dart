import 'package:finova/logic/view_models/auth_state.dart';
import 'package:finova/providers/auth_logic_provider.dart';
import 'package:finova/views/Auth_view/screen/create_pin_Screen.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';

class OtpAuthScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final bool isRegistering;
  final String? enteredPinForLogin;

  const OtpAuthScreen({
    super.key,
    required this.phoneNumber,
    required this.isRegistering,
    this.enteredPinForLogin,
  });

  @override
  ConsumerState<OtpAuthScreen> createState() => _OtpAuthScreenState();
}

class _OtpAuthScreenState extends ConsumerState<OtpAuthScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController;
    super.dispose();
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      ref.read(authLogicProvider.notifier);
      final smsCode = _otpController.text.trim();
      onSuccess:
      (UserCredential) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('OTP Verified!')));
        if (widget.isRegistering) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CreatePinScreen(
                    phoneNumber: widget.phoneNumber,
                    uid: UserCredential.user!.uid,
                  ),
            ),
          );
        } else {
          if (widget.enteredPinForLogin == null ||
              widget.enteredPinForLogin!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error: PIN not provided for login.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          ref
              .read(authLogicProvider.notifier)
              .checkPinAfterFirebaseLogin(
                uid: UserCredential.user!.uid,
                enterPin: widget.enteredPinForLogin!,
                onSuccess: (userModel) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Login successful! ${userModel.phoneNumber}',
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
                      content: Text('OTP Error:$message'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
        }
      };

      void _resendOtp() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Resending Otp...')));
        ref
            .read(authLogicProvider.notifier)
            .sendOtp(
              phoneNumber: widget.phoneNumber,
              onCodeSent: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('New OTP Sent!')));
              },
              onError: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Resend Error: $message'),
                    backgroundColor: Colors.red,
                  ),
                );
              },

              onAutoRetrival: (userCredential) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP Auto-retrieved!')),
                );
                if (widget.isRegistering) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreatePinScreen(
                            uid: userCredential.user!.uid,
                            phoneNumber: widget.phoneNumber,
                          ),
                    ),
                  );
                } else {
                  if (widget.enteredPinForLogin == null) return;

                  ref
                      .read(authLogicProvider.notifier)
                      .checkPinAfterFirebaseLogin(
                        uid: userCredential.user!.uid,
                        enterPin: widget.enteredPinForLogin!,
                        onError: (message) {},
                        onSuccess: (userModel) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      );
                }
              },
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authLogicProvider);

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
                controller: _otpController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 4) {
                    return 'Please enter the 6-digit Otp';
                  }
                  return null;
                },
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
                    Container(width: 22, height: 2, color: Colors.greenAccent),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // TextButton(
              //   onPressed:
              //       (authState is AuthLoading)
              //           ? null
              //           : _resendOtp(), // Disable while loading
              //   child: const Text('Resend OTP'),
              // ),
              Spacer(),

              if (authState is AuthLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 130,
                    //   vertical: 20,
                    // ),
                    elevation: 0,
                  ),
                  onPressed: _verifyOtp,
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
