import 'dart:ui';
import 'package:finova/providers/firebase_instances_provider.dart';
import 'package:finova/providers/shared_preference_provider.dart';
import 'auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finova/core/constants/firestore_collections.dart';
import 'package:finova/core/utils/pin_hasher.dart';
import 'package:finova/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


class AuthLogic extends StateNotifier<AuthState> {
  final Ref ref;

  //phone number during otp process
  // Stores Firebase verification ID for OTP
  String? _verificationId;
  String? _phoneNumber;

  AuthLogic(this.ref) : super(const AuthInitial());

  // Private getters for Firebase services via Riverpod
  FirebaseAuth get _auth => ref.read(firebaseAuthProvider);

  FirebaseFirestore get _firestore => ref.read(firestoreProvider);

  ///1.SENDS AN OTP TO PROVIDER PHONE NUMBER

  ///   Called when OTP is sent, UI should navigate to OTP screen
  ///   Called on verification failure
  ///   Called on auto-retrieval
  ///   Store for later use if needed (e.g. with AuthCodeVerified state)
  ///
  Future<void> sendOtp({
    required String phoneNumber,
    required VoidCallback onCodeSent,
    required Function(String) onError,
    required Function(UserCredential) onAutoRetrival,
  }) async {
    state = AuthLoading();
    _phoneNumber = phoneNumber;

    try {
      await _auth.verifyPhoneNumber(
        ///
        verificationCompleted: (PhoneAuthCredential credential) async {
          state = AuthLoading();

          try {
            UserCredential userCredential = await _auth.signInWithCredential(credential);
              
            state = AuthCodeVerified(userCredential, phoneNumber);
            onAutoRetrival(userCredential);
          } on FirebaseAuthException catch (e) {
            state = AuthError(e.message ?? "Auto -retrieval sign in failed ");
          }
        },

        ///
        verificationFailed: (FirebaseAuthException e) {
          state = AuthError(e.message ?? "Phone number verification failed ");
          onError(e.message ?? "phone number verification failed ");
        },

        ///
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          state = AuthCodeSent(verificationId, phoneNumber);
          onCodeSent();
        },

        //
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      state = AuthError(e.toString());
      onError(e.toString());
    }
  }

  ///2. VERIFIES THE OTP CODE ENTERED BY THE USER.
  /// line 83. (UserCredential containing the Firebase user)
  /// \\ user is now signed in with firebase.      
  /// \\ Transition state to AuthCodeVerified, which includes the userCredential and phone number.      
  /// \\ The UI can then use this to proceed to PIN creation (for new users) or PIN verification (for existing users).
  Future<void> verifyOtp({
    required String smsCode,
    required Function(UserCredential) onSuccess,
    required Function(String) onError,
  }) async {
    if (_verificationId == null) {
      final errMsg =
          "verification ID not found. please try Sending Otp Again  ";
      state = const AuthError("verification ID not found. please try Sending Otp Again ");
      onError(errMsg);
      return;
    }
    if (_phoneNumber == null) {
      final errMsg =
          "Phone number not found during Otp verification Please retry";
          onError(errMsg);
          return;
    }
    state = const AuthLoading();
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      state = AuthCodeVerified(userCredential, _phoneNumber!);
      onSuccess(userCredential);
    } on FirebaseAuthException catch(e){
      state = AuthError(e.message  ?? "Otp verification failed.");
    } catch (e){
      state = AuthError(e.toString());
      onError(e.toString());
    }
  }


  /// 3. CREATE ACOUNT WITH PIN 
  //Creates a new user account in Firestore with a hashed PIN.
 //This is typically called after OTP verification for a new user.
// 
//

Future<void> createAccountWithPin({
  required String pin,
  required String phoneNumber,
  required String uid,
  required Function(UserModel) onSuccess,
  required Function(String) onError,
}) async{
  state = const AuthLoading();

  try{
   final String hashedPin = PinHasher.hashPin(pin);
   final UserModel  newUser = UserModel(
    uid: uid, 
    phoneNumber: phoneNumber, 
    pinhash: hashedPin, 
    createdAt: Timestamp.now(),
   );
   await _firestore
   .collection(FirestoreCollections.users)
   .doc(uid)
   .set(newUser.toJson());

   await  markAsOpened(ref.read);
   state = AuthPinSetSuccess(newUser);
   onSuccess(newUser);
  }catch(e){
    state = AuthError(e.toString());
    onError(e.toString());
  }
}



/// 4. CHECK PIN AFTER FIREBASE LOGIN 

Future<void> checkPinAfterFirebaseLogin({
 required String uid,
 required String enterPin,
 required Function(UserModel) onSuccess,
 required Function(String) onError,

})async{
  state = const AuthLoading();
  try{

    final userDoc = await _firestore
    .collection(FirestoreCollections.users)
    .doc(uid)
    .get();

    if (userDoc.exists && userDoc.data() != null){
      final userModel = UserModel.fromJson(userDoc.data()!);


      if (PinHasher.verifyPin(enterPin, userModel.pinhash)){
        await markAsOpened(ref.read);
        state =  AuthLoggedInWithPin(userModel);
        onSuccess(userModel);
      }
    } else{
      state = const AuthError("incorrect pin ");
      onError("incorrect pin ");
    }
  }catch (e){
    state = AuthError(e.toString());
    onError(e.toString());
    
  }
}

  /// 5.  SIGN OUT 
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      state = const AuthInitial();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}

  // void resetState(){
  //   _verificationId = null;
  //   _phoneNumber = null ;
  //   state = AuthInitial();
  


