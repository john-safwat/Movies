import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Providers/DataProvider.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/getHistoryUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getUserDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/PosterImage.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:provider/provider.dart';

class ProfileTabView extends StatefulWidget {
  static const String routeName = 'ProfileTab';
  static const String path = '/ProfileTab';

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  ProfileTabViewModel viewModel = ProfileTabViewModel(GetUserDataUseCase(injectUserRepository()), GetHistoryUseCase(injectMoviesRepository()));
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    viewModel.provider = Provider.of<AppConfigProvider>(context,listen: false);
    viewModel.dataProvider = Provider.of<DataProvider>(context,listen: false);
    viewModel.homeScreenViewModel = Provider.of<HomeScreenViewModel>(context , listen: false);
    viewModel.getData();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dataProvider = null ;
    viewModel.provider = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileTabViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<ProfileTabViewModel , BaseCubitState>(
        listener: (context, state) {
          if(state is MovieDetailsAction){
            viewModel.homeScreenViewModel!.setSelectedIndex(9);
            context.pushNamed(MovieDetailsScreen.routeName, extra: state.movie);
          }
        },

        buildWhen: (previous, current) {
          if(previous is LoadingState && current is DataLoadedState){
            return true ;
          }else {
            return false;
          }
        },

        builder: (context, state) {
          if(state is LoadingState){
            return const Center(
              child: CircularProgressIndicator(
                color: MyTheme.gold,
              ),
            );
          } else if(state is ErrorState){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage , style: const TextStyle(color: Colors.white),),
                ElevatedButton(
                    onPressed: (){
                      viewModel.getData();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    ) ,
                    child:const Text(
                        "Try Again"
                    )
                )
              ],
            );
          }else if (state is DataLoadedState){
            return DefaultTabController(
              length: 2,
              initialIndex: 0,
              child:NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(

                    toolbarHeight: 250,
                    backgroundColor: MyTheme.blackThree,
                    title: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 30),
                            child: Row(
                              children: [
                                Image.asset(state.user.image),
                                const SizedBox(width: 20,),
                                Expanded(child: Text(state.user.name , style: Theme.of(context).textTheme.headline3,))
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                              ),
                              child: Text("Edit Profile" , style: Theme.of(context).textTheme.headline5,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    leading: Container(),
                    leadingWidth: 0,
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(90),
                      child: TabBar(
                        indicatorColor: MyTheme.gold,
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Icon(EvaIcons.list , color: MyTheme.gold,),
                                Text("Favorite List " , style: Theme.of(context).textTheme.headline5,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Icon(EvaIcons.archive , color: MyTheme.gold,),
                                Text("History " , style: Theme.of(context).textTheme.headline5,),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ],
                body: Column(
                  children: [
                    SizedBox(height: 20,),
                    Expanded(
                        child: TabBarView(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              // physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10 ,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.65
                              ),
                              itemBuilder: (context, index) => PosterImage(
                                movie: state.movies[index],
                                goToDetailsScreen: viewModel.goToDetailsScreen,
                              ),
                              itemCount: state.movies.length,
                            ),
                            GridView.builder(
                              shrinkWrap: true,

                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10 ,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.65
                              ),
                              itemBuilder: (context, index) => PosterImage(
                                movie: state.movies[index],
                                goToDetailsScreen: viewModel.goToDetailsScreen,
                              ),
                              itemCount: state.movies.length,
                            )
                          ],
                        )
                    )
                  ],
                ),
              ) ,
            );
          }else {
            return Container();
          }
        },
      ),
    );
  }
}
