import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/storage/constants/constants.dart';
import 'package:news_app/storage/models/models.dart';

final userInfoStorageProvider = Provider<UserInfoStorage>(
  (ref) => UserInfoStorage(),
);

@immutable
class UserInfoStorage {
  UserInfoStorage({
    FirebaseFirestore? firestoreOverride,
  }) : firestoreInstance = firestoreOverride ?? FirebaseFirestore.instance;

  late final FirebaseFirestore firestoreInstance;

  Future<bool> saveUserInfo({
    required User user,
  }) async {
    try {
      final userInfo = await firestoreInstance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: user.uid,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // We already have this user's info
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: user.displayName,
          FirebaseFieldName.email: user.email,
          FirebaseFieldName.photoUrl: user.photoURL,
        });
        return true;
      }

      // we don't have this user's info so we create a new user
      final payload = UserInfoPayload(
        userId: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
      );
      await firestoreInstance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(
            payload,
          );
      return true;
    } catch (e) {
      e.log();
      return false;
    }
  }
}
