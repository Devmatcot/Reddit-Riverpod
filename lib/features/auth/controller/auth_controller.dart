import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utilis/snackbar.dart';
import '../../../model/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));
final userProvider = StateProvider<UserModel?>((ref) {
  return null;
});
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  AuthRepository _authRepository;
  Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  sigInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.singWithGoogle();
    state = false;
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  signOutUser() {
    state = true;
    _authRepository.logOutUser();
    state = false;
  }
}
