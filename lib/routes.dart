//logout route
import 'package:flutter/material.dart';
import 'package:flutter_reddit/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/community/screen/community_screen.dart';
import 'features/community/screen/create_community.dart';
import 'features/community/screen/edit_communities_screen.dart';
import 'features/community/screen/mod_tools_screen.dart';
import 'features/home/screens/home_screen.dart';

final logOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: LoginScreen(),
      )
});

final logInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: HomeScreen(),
        ),
    CreateCommunityScreen.path: (_) => const MaterialPage(
          child: CreateCommunityScreen(),
        ),
    '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(communityName: route.pathParameters['name']!)),
    '/mod-tools/:name': (route) => MaterialPage(
            child: ModToolsScreen(
          name: route.pathParameters['name']!,
        )),
    '/edit-community/:name': (route) => MaterialPage(
            child: EditCommunitiesScreen(
          name: route.pathParameters['name']!,
        ))
  },
);
