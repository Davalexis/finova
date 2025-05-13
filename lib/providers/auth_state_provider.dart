import 'package:firebase_auth/firebase_auth.dart'; // For User and FirebaseAuth
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_instances_provider.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return firebaseAuth.authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  return authState.asData?.value;
});
