import 'package:finova/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() =>
    AsyncValue.data(null);

    Future<void> submitPhone(String  phoneNumber , WidgetRef ref, BuildContext context)
    async{
      state = AsyncValue.loading();
      final authRepo = ref.read(authRepositoryProvider);

      try {
        final exist = await authRepo.checkIfUserExist(phoneNumber);
        state = const  AsyncValue.data(null);

        if (exist){
          Navigator.pushNamed(context, '/LoginScreen()' );}

          else {
            Navigator.pushNamed(context, '/CreateAcctScreen()');
          }
        } catch (e,st){
          state = AsyncValue.error(e,st);
        }
      }
    }
    


   
  


