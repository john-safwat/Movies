import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/DataProvider.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesByGenreUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MoviesLists.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/Widgets/MyPlaceHolder.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/Widgets/TopRatedMovies.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:provider/provider.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';


class HomeTabView extends StatefulWidget {
  static const String routeName = 'HomeTab';
  static const String path = '/HomeTab';

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  HomeTabViewModel viewModel = HomeTabViewModel(
      GetMoviesDataUseCase(injectMoviesRepository()),
      GetMoviesByGenreUseCase(injectMoviesRepository()));
  @override
  void initState() {
    super.initState();
    viewModel.provider = Provider.of<DataProvider>(context,listen: false);
    viewModel.homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    viewModel.readData();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.provider = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeTabViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<HomeTabViewModel, BaseCubitState>(
        listener: (context, state) {
          if(state is MovieDetailsAction){
            viewModel.homeScreenViewModel?.setSelectedIndex(9);
            context.pushNamed(MovieDetailsScreen.routeName , extra: state.movie.id);
          }
        },
        buildWhen: (previous, current) {
          if(previous is LoadingState && current is MoviesLoadedState){
            return true;
          }else if (previous is LoadingState && current is ErrorState){
            return true;
          }else if (previous is ErrorState && current is LoadingState){
            return true;
          }else if (previous is RefreshState && current is MoviesLoadedState){
            return true;
          }else if (previous is RefreshState && current is ErrorState ){
            return true;
          }else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return MyPlaceHolder();
          } else if (state is MoviesLoadedState) {
            return RefreshIndicator(
              onRefresh: viewModel.refreshData,
              color: MyTheme.gold,
              child: SingleChildScrollView(
                  child: Column(
                  children: [
                    TopRatedMovies(movies: state.movies! , goToDetailsScreen: viewModel.goToDetailsScreen),
                    const SizedBox(
                      height: 10,
                    ),
                    Movieslist(
                      movies: state.actionMovies!,
                      type: "Action Movies",
                      goToDetailsScreen: viewModel.goToDetailsScreen
                    ),
                    Movieslist(
                      movies: state.crimeMovies!,
                      type: "Crime Movies  ",
                      goToDetailsScreen: viewModel.goToDetailsScreen
                    ),
                    Movieslist(
                      movies: state.dramaMovies!,
                      type: "Drama Movies",
                      goToDetailsScreen: viewModel.goToDetailsScreen
                    ),
                    Movieslist(
                      movies: state.animationMovies!,
                      type: "Animation Movies",
                      goToDetailsScreen: viewModel.goToDetailsScreen
                    ),
                  ],
              )),
            );
          } else if(state is ErrorState){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage , style: const TextStyle(color: Colors.white),),
                ElevatedButton(
                    onPressed: (){
                      viewModel.readData();
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
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
