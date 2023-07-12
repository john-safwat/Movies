import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Presentation/Intro/IntroScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Welcome/WelcomeScreen.dart';


class IntroScreenView extends StatefulWidget {
  const IntroScreenView({super.key});
  static const String routeName = 'IntroScreen';
  static const String path = '/IntroScreen';

  @override
  State<IntroScreenView> createState() => _IntroScreenViewState();
}

class _IntroScreenViewState extends State<IntroScreenView> {
  IntroScreenViewModel viewModel = IntroScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroScreenViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<IntroScreenViewModel , BaseCubitState>(
        listener: (context, state) {
          if(state is GoToWelcomeScreenAction){
            GoRouter.of(context).goNamed(WelcomeScreen.routeName);
          }
        },
        builder: (context, state) => Scaffold(body: viewModel.tabs[viewModel.currentIndex]),
      ),
    );
  }
}

