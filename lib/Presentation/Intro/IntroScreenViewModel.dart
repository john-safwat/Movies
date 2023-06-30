import 'package:flutter/material.dart';
import 'package:mymoviesapp/Presentation/Intro/IntroScreenNavigator.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/FirstTab.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/LastTab.dart';
import 'package:mymoviesapp/Presentation/Intro/Widgets/SecondTab.dart';

class IntroScreenViewModel extends ChangeNotifier {
  List<Widget> tabs = [] ;
  int currentIndex = 0 ;
  IntroScreenNavigator? navigator;

  void setWidgets(){
    tabs.add(FirstTab(changeIndexCallBack: changeIndex));
    tabs.add(SecondTab(changeIndexCallBack: changeIndex));
    tabs.add(LastTab(changeIndexCallBack: changeIndex));
  }
  void changeIndex(int newIndex){
    if(newIndex == 3){
      navigator!.goToWelcomeScreen();
      return;
    }
    currentIndex = newIndex ;
    notifyListeners();
  }
}