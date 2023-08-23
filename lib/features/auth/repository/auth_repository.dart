import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/core/constants/firebase_constants.dart';
import 'package:flutter_reddit/core/extenstion/log.dart';
import 'package:flutter_reddit/provider/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/user_model.dart';
import '../../../provider/firebase_provider.dart';
import '../../../provider/typedef.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      auth: ref.read(authProvider),
      firestore: ref.read(fireStoreProvider),
      googleSignIn: ref.read(googleProvider));
});




class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  AuthRepository(
      {required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      required GoogleSignIn googleSignIn})
      : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<UserModel> singWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? auth = await googleUser?.authentication;
      final crediential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(crediential);
      User? userDetails = userCredential.user;
      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userDetails!.displayName ?? 'No Name',
            profilePic: userDetails.photoURL ?? Constants.avatarDefault,
            banner: Constants.bannerDefault,
            uid: userDetails.uid,
            isAuthenticated: userCredential.user?.uid != null,
            karma: 0,
            awards: []);
        await _users.doc(userModel.uid).set(userModel.toMap());
        return right(userModel);
      } else {
        'working on this'.log();
        userModel = await getUserData(userDetails!.uid).first;
        // userModel.toString().log();
      }
      return right(userModel);
    } catch (e) {
      e.log();
      return left(Failure(e.toString()));
    }
  }

  logOutUser() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) {
      event.data()!.runtimeType.log();
      return UserModel.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}
