import 'package:flutter/material.dart';
import 'package:flutter_reddit/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utilis/snackbar.dart';
import '../../../model/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.read(authRepositoryProvider), ref: ref));
final userProvider = StateProvider<UserModel?>((ref) {
  return null;
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

  signOutUser() {
    state = true;
    _authRepository.logOutUser();
    state = false;
  }
}
