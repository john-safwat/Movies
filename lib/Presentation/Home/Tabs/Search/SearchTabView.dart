import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/getSearchResultsUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/PosterImage.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Search/SearchTabViewModel.dart';
import 'package:mymoviesapp/Core/DI/di.dart';

import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SearchTabView extends StatefulWidget {
  static const String routeName = 'SearchTab';
  static const String path = '/SearchTab';

  @override
  State<SearchTabView> createState() => _SearchTabViewState();
}

class _SearchTabViewState extends State<SearchTabView> {
  SearchTabViewModel viewModel = SearchTabViewModel(GetSearchResultsUseCase(injectSearchRepo()));
  @override
  void initState() {
    super.initState();
    viewModel.homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Column(
        children: [
          AppBar(
            backgroundColor: MyTheme.backGroundColor,
            elevation: 0,
            title: TextField(
              onChanged: (value) {
                viewModel.getSearchResults(value);
              },
              cursorColor: MyTheme.gray,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                filled: true,
                contentPadding:const  EdgeInsets.all(10),
                fillColor: MyTheme.blackFour,
                hintText: "Search",
                hintStyle: const TextStyle(color: MyTheme.gray, fontSize: 18),
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: MyTheme.gray,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
              ),
            ),
            toolbarHeight: 80,
          ),
          Expanded(
            child: BlocConsumer<SearchTabViewModel, BaseCubitState>(
              listener: (context, state) {
                if(state is MovieDetailsAction){
                  GoRouter.of(context).pushNamed( MovieDetailsScreen.routeName , extra: state.movie.id);
                  viewModel.homeScreenViewModel!.setSelectedIndex(9);
                }
              },
              buildWhen: (previous, current) {
                if(previous is EmptyListState && current is LoadingState){
                  return true;
                }else if (previous is LoadingState && current is EmptyListState){
                  return true;
                }else if (previous is LoadingState && current is MoviesLoadedState){
                  return true;
                }else if (previous is LoadingState && current is ErrorState){
                  return true;
                }else if (previous is MoviesLoadedState && current is LoadingState){
                  return true;
                }else if (previous is ErrorState && current is LoadingState){
                  return true;
                }else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is EmptyListState) {
                  return Center(child: Image.asset('assets/images/Empty.png'),);
                }else if(state is LoadingState){
                  return Center(child: CircularProgressIndicator(color: MyTheme.gold,),);
                } else if (state is MoviesLoadedState) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20 ,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.65
                            ),
                            itemBuilder: (context, index) => PosterImage(
                                movie: state.movies[index],
                                goToDetailsScreen: viewModel.goToDetailsScreen,
                            ),
                            itemCount: state.movies.length,
                          ),
                        )
                      ),
                    ],
                  );
                } else if (state is ErrorState) {
                  return Center(child: Image.asset('assets/images/Empty.png'),);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
