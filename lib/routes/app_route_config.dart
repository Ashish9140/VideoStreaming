import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_tutorial/main.dart';
import 'package:webrtc_tutorial/routes/app_route_constants.dart';
import 'package:webrtc_tutorial/second.dart';
import 'package:webrtc_tutorial/test.dart';


class GoRouterConfig {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: AppRouteNames.initialScreenRoute,
          path: '/',
          pageBuilder: (context, state) {
            return  MaterialPage(child: InitialPage());
          },
          routes: [
             GoRoute(
                name: AppRouteNames.homeScreenRoute,
                path: 'home/:roomId',
                pageBuilder: (context, state) {
                  return MaterialPage(child: MyHomePage(id:  state.pathParameters['roomId']!));
                },
               ),
             GoRoute(
                name: AppRouteNames.testScreenRoute,
                path: 'test/:id',
                pageBuilder: (context, state) {
                  

                  return MaterialPage(
                      child: TestPage(id:  state.pathParameters['id']!));
                },
                ),
          ]
      ),
      
           
    ]
 
  );
}
