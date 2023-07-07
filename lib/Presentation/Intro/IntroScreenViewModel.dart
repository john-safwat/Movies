import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/FirstTab.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/LastTab.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/SecondTab.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroScreenViewModel extends Cubit<BaseCubitState>{
  IntroScreenViewModel():super(TabsState());

  late List<Widget> tabs = [
    FirstTab(changeIndexCallBack: changeIndex),
    SecondTab(changeIndexCallBack: changeIndex),
    LastTab(changeIndexCallBack: changeIndex)
  ];

  int currentIndex = 0;

  void changeIndex(int newIndex)async{
    if(newIndex == 3){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("introDone", true);
      emit(GoToWelcomeScreenAction());
      return;
    }
    currentIndex = newIndex ;
    emit(TabsState());
  }
}

class TabsState extends BaseCubitState{}
class GoToWelcomeScreenAction extends BaseCubitState{}

