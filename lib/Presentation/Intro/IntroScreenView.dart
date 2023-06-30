import 'package:flutter/material.dart';
import 'package:mymoviesapp/Presentation/Intro/IntroScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Welcome/WelcomeScreen.dart';
import 'package:provider/provider.dart';

import 'IntroScreenNavigator.dart';

class IntroScreenView extends StatefulWidget {
  static const String routeName = 'IntroScreen';
  static const String path = '/IntroScreen';

  @override
  State<IntroScreenView> createState() => _IntroScreenViewState();
}

class _IntroScreenViewState extends State<IntroScreenView> implements IntroScreenNavigator{
  IntroScreenViewModel viewModel = IntroScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.setWidgets();
  }
  @override
  void dispose() {
    super.dispose();
    viewModel.navigator = null ;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<IntroScreenViewModel>(
        builder: (context, value, child) =>  Scaffold(
          body: value.tabs[value.currentIndex],
        ),
      ),
    );
  }

  @override
  void goToWelcomeScreen() {
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
  }


}
