import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/core/extenstion/widget.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/sign_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOutUser();
            },
            child: const Text('Skip',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.0.spacingH,
          const Text(
            'Dive into anythings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          30.0.spacingH,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Constants.loginEmotePath,
              height: 400,
            ),
          ),
          ref.watch(authControllerProvider)? CircularProgressIndicator(): SignInButton()
        ],
      ),
    );
  }
}
