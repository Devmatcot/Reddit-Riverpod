import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/firebase_options.dart';
import 'package:flutter_reddit/routes.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/loader.dart';
import 'features/auth/screens/login_screen.dart';
import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
        data: (user) {
          return MaterialApp.router(
            title: 'Reddit App',
            
            theme: Pallete.darkModeAppTheme,
            debugShowCheckedModeBanner: false,
            // home: const LoginScreen(),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (user != null) {
                getData(ref, user);
                return logInRoute;
              } else {
                return logOutRoute;
              }
            }),
            routeInformationParser: const RoutemasterParser(),
          );
        },
        error: (e, d) => Text('error occur ${e.toString()}'),
        loading: () => const Loader());
  }
}
