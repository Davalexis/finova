import 'package:finova/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_instances_provider.dart';
import '../core/constants/firestore_collections.dart';

final userDocumentProvider = StreamProvider.autoDispose
    .family<UserModel?, String>((ref, String uid) {
      if (uid.isEmpty) {
        return Stream.value(null);
      }

      final firestore = ref.watch(firestoreProvider);

      final userDocRef = firestore
          .collection(FirestoreCollections.users)
          .doc(uid);

      return userDocRef
          .snapshots()
          .map((snapshot) {
            if (snapshot.exists && snapshot.data() != null) {
              try {
                return UserModel.fromJson(snapshot.data()!);
              } catch (e) {
                print('Error parsing UserModel for UID $uid: $e');

                return null;
              }
            } else {
              return null;
            }
          })
          .handleError((error) {
            print('Error fetching user document for UID $uid: $error');

            throw error;
          });
    });
