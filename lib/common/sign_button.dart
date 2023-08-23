import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});
  signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).sigInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Pallete.greyColor),
          onPressed: () => signInWithGoogle(context, ref),
          icon: Image.asset(Constants.googlePath, height: 35),
          label: const Text(
            'Continue with Google',
            style: TextStyle(fontSize: 18),
          )),
    );
  }
}
