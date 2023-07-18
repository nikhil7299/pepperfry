// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pepperfry/features/auth/controller/auth_controller.dart';
// import 'package:pepperfry/features/auth/view/auth_splash_view.dart';
// import 'package:pepperfry/features/auth/view/login_view_button.dart';
// import 'package:pepperfry/features/auth/view/signup_login_form.dart';
// import 'package:pepperfry/features/home/view/home_view.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
// final _modalShellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'modalShell');

// final goRouterProvider = Provider<GoRouter>((ref) {
//   print('router rebuilt');
//   return GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     observers: [NavigatorObserver()],
//     debugLogDiagnostics: true,
//     initialLocation: '/authSplash',
//     routes: [
//       GoRoute(
//         path: '/',
//         name: 'home',
//         builder: (context, state) {
//           return HomeView();
//         },
//       ),
//       GoRoute(
//         path: '/authSplash',
//         name: 'authSplash',
//         builder: (context, state) {
//           return AuthSplashView();
//         },
//       ),
//       // ShellRoute(
//       //     navigatorKey: _modalShellNavigatorKey,
//       //     builder: (context, state, child) {
//       //       return BottomSheet(
//       //         onClosing: () {},
//       //         builder: (context) {
//       //           return ModalBottomSheetContent(child: child);
//       //         },
//       //       );
//       //     },
//       //     routes: [
//       //       GoRoute(
//       //           path: '/authForm',
//       //           name: 'authForm',
//       //           builder: (context, state) => SignUpLogInForm(),
//       //           routes: [
//       //             GoRoute(
//       //               path: '/otpLogin',
//       //               name: 'otpLogin',
//       //               builder: (context, state) => LoginSheet(),
//       //             ),
//       //             GoRoute(
//       //               path: '/signUp',
//       //               name: 'signUp',
//       //               builder: (context, state) => CompleteSignUp(),
//       //             ),
//       //           ]),
//       //     ])
//       // GoRoute(
//       //   path: '/authForm',
//       //   name: 'authForm',
//       //   builder: (context, state) => SignUpLogInForm(
//       //     key: state.pageKey,
//       //   ),
//       // ),
//       // GoRoute(
//       //   path: '/otpLogin',
//       //   name: 'otpLogin',
//       //   builder: (context, state) => LoginSheet(
//       //     key: state.pageKey,
//       //   ),
//       // ),
//     ],
//     redirect: (context, state) async {
//       final isLoggedIn = ref.watch(isLoggedInProvider);
//       final isAuthSkipped = ref.watch(isAuthSkippedProvider);
//       return isAuthSkipped.when(
//         data: (authSkipped) => authSkipped || isLoggedIn
//             // || state.matchedLocation =='/'
//             ? state.namedLocation('home')
//             : state.namedLocation('authSplash'),
//         loading: () {
//           print('loading');
//           // return const Center(
//           //     child: CircularProgressIndicator(
//           //   semanticsLabel: 'Loading...',
//           // ));
//         },
//         error: (error, stackTrace) {
//           print(stackTrace);
//           // return Center(
//           //   child: Text(error.toString()),
//           // );
//         },
//       );
//     },
//     // errorBuilder: (context, state) => RouteError,
//   );
// });
