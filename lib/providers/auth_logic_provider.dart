import 'package:finova/logic/view_models/auth_logic.dart';
import 'package:finova/logic/view_models/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLogicProvider = StateNotifierProvider<AuthLogic, AuthState>((ref) {
  return AuthLogic(ref);
});