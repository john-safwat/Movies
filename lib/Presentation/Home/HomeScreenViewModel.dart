import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Browse/BrowseTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/EditProfileScreen/EditProfileView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Profile/ProfileTabVIew.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Search/SearchTabView.dart';

class HomeScreenViewModel extends Cubit<BaseCubitState>{

  HomeScreenViewModel():super(HomeTabState());

  GoRouter? router ;
  int selectedIndex = 0;


  // change the selected index of the pages in case of the tab is movie details tab will be the last selected index
  void setSelectedIndex(int index){
    if(index != 9){
      selectedIndex = index;
      updateState(index);
    }
  }

  // change the state of the code depend on the index from the setSelected state function
  void updateState(int index){
    if(index == 0){
      emit(HomeTabState());
    }else if (index == 1){
      emit(SearchTabState());
    }else if (index == 2){
      emit(BrowseTabState());
    }else if (index == 3){
      emit(ProfileTabState());
    }
  }

  // change the current selected icon depend on the route path
  int setCurrentIndex(){
    if(router!.location == HomeTabView.path){
      selectedIndex = 0;
      return 0;
    }else if(router!.location == SearchTabView.path){
      selectedIndex = 1;
      return 1;
    }else if(router!.location == BrowseTabView.path){
      selectedIndex = 2;
      return 2;
    }else if(router!.location == ProfileTabView.path){
      selectedIndex = 3;
      return 3;
    }else if(router!.location == MovieDetailsScreen.path){
      return selectedIndex;
    }else if(router!.location == EditProfileView.path){
      return selectedIndex;
    }
    return 0;
  }

}

class HomeTabState extends BaseCubitState{}
class SearchTabState extends BaseCubitState{}
class BrowseTabState extends BaseCubitState{}
class ProfileTabState extends BaseCubitState{}
class BackState extends BaseCubitState{}