import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Browse/BrowseTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Profile/ProfileTabVIew.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Search/SearchTabView.dart';
import 'package:unicons/unicons.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  static const String path = '/Home';

  Widget tab;
  HomeScreen({required this.tab});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setSelectedIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.router = GoRouter.of(context);
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<HomeScreenViewModel , BaseCubitState>(
        listener: (context, state) {
          if(state is HomeTabState){
            context.push(HomeTabView.path);
          } else if (state is SearchTabState){
            context.push(SearchTabView.path);
          } else if (state is BrowseTabState){
            context.push(BrowseTabView.path);
          } else if (state is ProfileTabState){
            context.push(ProfileTabView.path);
          }
        },
        builder:(context, state) => Scaffold(
          body: widget.tab,
          extendBody: true,
          bottomNavigationBar: DotNavigationBar(
            boxShadow: const [
              BoxShadow(
                color: MyTheme.backGroundColor,
                offset: Offset(0, 5),
                blurRadius: 20,
                spreadRadius: 5
              ),
            ],
            selectedItemColor: MyTheme.gold,
            unselectedItemColor: MyTheme.gray,
            enablePaddingAnimation: false,
            onTap: (value) => viewModel.setSelectedIndex(value),
            currentIndex: viewModel.setCurrentIndex(),
            borderRadius: 20,
            backgroundColor: MyTheme.blackOne,
            marginR: const EdgeInsets.all(15),
            paddingR:const  EdgeInsets.symmetric(vertical: 10),
            dotIndicatorColor: Colors.transparent,
            items: [
              DotNavigationBarItem(icon: const Icon(UniconsLine.estate),),
              DotNavigationBarItem(icon: const Icon(EvaIcons.search),),
              DotNavigationBarItem(icon: const Icon(EvaIcons.browserOutline),),
              DotNavigationBarItem(icon: const Icon(LineIcons.userCircle),),
            ],
          )
          ),
        ),
    );
  }
}
