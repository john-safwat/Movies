

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Providers/DataProvider.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenView.dart';
import 'package:dcdg/dcdg.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Browse/BrowseTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Profile/ProfileTabVIew.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Search/SearchTabView.dart';
import 'package:mymoviesapp/Presentation/Intro/IntroScreenView.dart';
import 'package:mymoviesapp/Presentation/Login/LoginScreen.dart';
import 'package:mymoviesapp/Presentation/Registration/RegistrationView.dart';
import 'package:mymoviesapp/Presentation/Welcome/WelcomeScreen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final router = GoRouter(
      initialLocation: WelcomeScreen.path,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          path: WelcomeScreen.path,
          name: WelcomeScreen.routeName,
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          path: IntroScreenView.path,
          name: IntroScreenView.routeName,
          builder: (context, state) => IntroScreenView(),
        ),
        GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.routeName,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: RegistrationScreen.path,
          name: RegistrationScreen.routeName,
          builder: (context, state) => RegistrationScreen(),
        ),
        ShellRoute(
            builder: (context, state, child) => HomeScreen(tab: child),
            routes: [
              GoRoute(
                path: HomeTabView.path,
                name: HomeTabView.routeName,
                builder: (context, state) => HomeTabView(),
              ),
              GoRoute(
                path: SearchTabView.path,
                name: SearchTabView.routeName,
                builder: (context, state) => SearchTabView(),
              ),
              GoRoute(
                path: BrowseTabView.path,
                name: BrowseTabView.routeName,
                builder: (context, state) => BrowseTabView(),
              ),
              GoRoute(
                path: ProfileTabView.path,
                name: ProfileTabView.routeName,
                builder: (context, state) => ProfileTabView(),
              ),
              GoRoute(
                path: MovieDetailsScreen.path,
                name: MovieDetailsScreen.routeName,
                builder: (context, state) => MovieDetailsScreen(
                  movie: state.extra as Movies,
                ),
              ),
            ]),

      ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => DataProvider())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: MyTheme.theme,
      ),
    );
  }
}
