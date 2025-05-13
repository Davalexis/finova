import 'package:finova/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable 
abstract class AuthState {
  const AuthState();
}


/// The initial state, before any authentication action has been taken.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Indicates that an authentication operation is currently in progress.
/// UI should typically show a loading indicator.
class AuthLoading extends AuthState {
  const AuthLoading();
}


///
class AuthCodeSent extends AuthState{
  final String verificationId; 
  final String phoneNumber;
  const AuthCodeSent(
    this.verificationId, 
    this.phoneNumber
    );
  @override 
  bool operator == (Object other ) =>
  identical( this, other) ||
   other is  AuthCodeSent && runtimeType == other.verificationId &&
    phoneNumber == other.phoneNumber;

    @override
    int get hashCode => verificationId.hashCode ^ phoneNumber.hashCode;
}

///
class AuthLoggedInWithPin extends AuthState{
  final UserModel userModel;
  const  AuthLoggedInWithPin(this.userModel);

  @override 
  bool operator == (Object other) => identical(this, other) ||
    other is AuthLoggedInWithPin && 
    runtimeType == other.runtimeType && 
    userModel == other.userModel  ;

  @override
  int get hashCode => userModel.uid.hashCode;
}

///
class AuthError  extends AuthState {
  final String message; 
  const AuthError(this.message);
  @override
  bool operator ==(Object other) =>
  identical(this, other) ||
  other is AuthError && 
  runtimeType == other.runtimeType && 
  message == other.message;

  @override
  int get hashCode => message.hashCode;
}


///
class AuthPinSetSuccess extends AuthState {
  final UserModel userModel;
  const AuthPinSetSuccess(this.userModel); // <<<< Expects a UserModel

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthPinSetSuccess &&
          runtimeType == other.runtimeType &&
          userModel.uid == other.userModel.uid;

  @override
  int get hashCode => userModel.uid.hashCode;
}



///
class AuthCodeVerified extends AuthState {
  final UserCredential userCredential;
  final String phoneNumber;
  const AuthCodeVerified(this.userCredential, this.phoneNumber); // <<<< Expects these two arguments

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCodeVerified &&
          runtimeType == other.runtimeType &&
          userCredential.user?.uid == other.userCredential.user?.uid &&
          phoneNumber == other.phoneNumber;

  @override
  int get hashCode => (userCredential.user?.uid.hashCode ?? 0) ^ phoneNumber.hashCode;
}

/// Indicates that the user has logged out successfully.
class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthLoggedOut && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Indicates that the user has not yet opened the app.
 class AuthSignedOut extends AuthState {
  const AuthSignedOut();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignedOut && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
  }