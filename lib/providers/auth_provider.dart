import 'package:finova/Repository/Auth_repository.dart';
import 'package:finova/View_models/Auth_controller.dart';
import 'package:finova/view_models/create_acct_controller.dart';
import 'package:finova/view_models/login_view_model.dart';
import 'package:finova/view_models/verify_pin_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

//
final  loginViewModelProvider = NotifierProvider <LoginViewModel, 
AsyncValue<void>>(() => LoginViewModel()

);
//HOLDS THE USERS ENTERD NUMBER
final phoneNumberProvider = StateProvider<String>((ref) => '');

//CONTROLLER FOR PHONE INPUT NUMBER
final phoneControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

//AUTH CONTROLLER
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(ref),
);


//
final pinControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});


//
final verifyPinControllerProvider = StateNotifierProvider<VerifyPinController, bool>(
  (ref) => VerifyPinController(ref),
);


//
final createAccountProvider =
    StateNotifierProvider<CreateAcctController, bool>(
  (ref) => CreateAcctController(ref),
);

//
final verificationIdProvider = StateProvider<String?>((ref) => null);



