import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_reddit/core/constants/firebase_constants.dart';
import 'package:flutter_reddit/model/user_model.dart';
import 'package:flutter_reddit/provider/failure.dart';
import 'package:flutter_reddit/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../provider/typedef.dart';

final userRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final firestore = ref.watch(fireStoreProvider);
  return UserProfileRepository(firestore: firestore);
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_user.doc(user.uid).set(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
