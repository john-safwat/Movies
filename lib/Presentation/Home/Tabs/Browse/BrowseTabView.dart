import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesByGenreToBrowseUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/PosterImage.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Browse/BrowseTabViewMode.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Browse/Widgets/TabButton.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';
import 'package:provider/provider.dart';

class BrowseTabView extends StatefulWidget {

  static const String routeName = 'BrowseTab';
  static const String path = '/BrowseTab';

  @override
  State<BrowseTabView> createState() => _BrowseTabViewState();
}

class _BrowseTabViewState extends State<BrowseTabView> {
  BrowseTabViewModel viewModel = BrowseTabViewModel(
      GetMoviesByGenreToBrowseUseCase(injectMoviesRepository()));

  @override
  void initState() {
    super.initState();
    viewModel.getMoviesByGenre(viewModel.genres[viewModel.selectedIndex], viewModel.pageNumber);
    viewModel.homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseTabViewModel>(
      create: (context) => viewModel,
      child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTabController(
                length: viewModel.genres.length,
                child: TabBar(
                  physics: const BouncingScrollPhysics(),
                  isScrollable: true,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicatorColor: Colors.transparent,
                  labelPadding: const EdgeInsets.all(5),
                  tabs: viewModel.genres
                      .map((item) => TabButton(
                            genre: item,
                            isSelected: viewModel.genres.indexOf(item) ==
                                viewModel.selectedIndex,
                          ))
                      .toList(),
                  onTap: (value) {
                    setState(() {
                      viewModel.changeTap(value);
                    });
                  },
                ),
              ),
            ),
            Expanded( child: BlocConsumer<BrowseTabViewModel, BaseCubitState>(
              listener: (context, state) {
                if (state is MovieDetailsAction) {
                  viewModel.homeScreenViewModel!.setSelectedIndex(9);
                  context.pushNamed(MovieDetailsScreen.routeName, extra: state.movie.id);
                }
              },
              buildWhen: (previous, current) {
                if (previous is LoadingState && current is MoviesLoadedState){
                  return true ;
                }else if ( current is LoadingState &&  previous is MoviesLoadedState){
                  return true ;
                }else if ( current is MoviesLoadedState &&  previous is MoviesLoadedState){
                  return true ;
                }else if ( current is LoadingState &&  previous is LoadingState){
                  return true ;
                }else if ( current is MoviesLoadedState &&  previous is MovieDetailsAction){
                  return true ;
                }else {
                  return false ;
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.gold,
                    ),
                  );
                } else if (state is ErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.changeToLoadingState();
                            viewModel.getMoviesByGenre(
                                viewModel.genres[viewModel.selectedIndex],
                                viewModel.pageNumber);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyTheme.gold),
                          ),
                          child: const Text("Try Again"))
                    ],
                  );
                } else if (state is MoviesLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20 ,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.65
                      ),
                      itemBuilder: (context, index) {
                        if (index < viewModel.movies.length) {
                          return PosterImage(movie : viewModel.movies[index],
                              goToDetailsScreen: viewModel.goToDetailsScreen);
                        } else {
                          viewModel.getMoviesByGenre(
                              viewModel.genres[viewModel.selectedIndex],
                              viewModel.pageNumber);
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: MyTheme.gold,
                            )),
                          );
                        }
                      },
                      itemCount: viewModel.movies.length + 1,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
    );
  }
}
