import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/addToHistoryUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getMovieFullDetailsUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getRelatedMoviesUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MoviesLists.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/MovieDetails/MovieDetailsViewModel.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  num? movieId;
  MovieDetailsScreen({required this.movieId, Key? key}) : super(key: key);
  static const String routeName = 'MovieDetailsScreen';
  static const String path = '/MovieDetailsScreen';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel(
      GetRelatedMoviesUseCase(injectMoviesRepository()),
      GetMovieFullDetailsUseCase(injectMoviesRepository()),
      AddToHistoryUseCase(injectMoviesRepository()),
  );

  @override
  void initState() {
    viewModel.homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    viewModel.provider = Provider.of<AppConfigProvider>(context , listen: false);
    viewModel.loadData(widget.movieId);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    viewModel.provider = null;
    viewModel.homeScreenViewModel = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<MovieDetailsViewModel, BaseCubitState>(
        listener: (context, state) {
          if (state is BackAction) {
            context.pop(context);
          } else if (state is MovieDetailsAction) {
            viewModel.homeScreenViewModel!.setSelectedIndex(9);
            context.pushNamed(MovieDetailsScreen.routeName, extra: state.movie.id);
          }
        },
        buildWhen: (previous, current) {
          if (current is DataLoadedState && previous is LoadingState) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyTheme.gold,
              ),
            );
          } else if (state is DataLoadedState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // the header
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // the poster image in the background
                          Image.asset('assets/images/loading.jpg'),
                          CachedNetworkImage(
                              imageUrl: state.movie.largeCoverImage!,
                              imageBuilder: (context, imageProvider) =>
                                  Image.network(state.movie.largeCoverImage!),
                              width: MediaQuery.of(context).size.width,
                              placeholder: (context, url) => Image.asset(
                                    'assets/images/loading.jpg',
                                  ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/error.png')),
                          // the gradient layer in the page
                          Positioned.fill(
                              child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  MyTheme.backGroundColor.withOpacity(0.3),
                                  MyTheme.backGroundColor.withOpacity(0.1),
                                  MyTheme.backGroundColor.withOpacity(0.7),
                                  MyTheme.backGroundColor.withOpacity(1),
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                          )),
                          // the center play button
                          InkWell(
                            onTap: () => viewModel.lunchURL(state.movie.url! , state.movie),
                            child: Center(
                                child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: MyTheme.gold,
                              ),
                              child: const Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 60,
                              ),
                            )),
                          ),
                          // the movie title nad date
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Movie title
                                      Expanded(
                                        child: Text(
                                          state.movie.titleEnglish!,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(state.movie.year!.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // watch the movie
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => viewModel.lunchURL(state.movie.url!, state.movie),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Watch",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                      ),

                      // the likes count and the movie duration and the rating
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            info(state.movie.likeCount!.toString(),
                                EvaIcons.heart),
                            const SizedBox(
                              width: 10,
                            ),
                            info("${state.movie.runtime!.toString()} m",
                                LineIcons.hourglassHalf),
                            const SizedBox(
                              width: 10,
                            ),
                            info(state.movie.rating!.toString(), EvaIcons.star),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      // the list of related movies
                      Movieslist(
                          movies: state.relatedMovies,
                          type: "Similar",
                          goToDetailsScreen: viewModel.goToDetailsScreen),
                      // the Genres of the Movie
                      title("Genres"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: MyTheme.blackFour,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                state.movie.genres![index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                          itemCount: state.movie.genres!.length,
                        ),
                      ),
                      // the movie  summary
                      const SizedBox(
                        height: 10,
                      ),
                      title("Cast"),
                      state.movie.cast == null ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("No Cast Available Now" , style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.normal),),
                      ): ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: MyTheme.blackOne,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin:const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                          child: Row(
                            children: [
                              state.movie.cast![index].urlSmallImage == null ?ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset('assets/images/user.png' , width: 70 , fit: BoxFit.cover,),
                              ):
                              CachedNetworkImage(
                                  imageUrl: state.movie.cast![index].urlSmallImage!,
                                  imageBuilder: (context, imageProvider) =>ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(state.movie.cast![index].urlSmallImage! , width: 70, fit: BoxFit.cover,),
                                  ),
                                  placeholder: (context, url) => Image.asset('assets/images/user.png', width: 70,),
                                  errorWidget: (context, url, error) => Image.asset('assets/images/user.png') , width: 70,),
                              const SizedBox(width: 20,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text("Name : ${state.movie.cast![index].name}", style: Theme.of(context).textTheme.headline5, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                Text("Character : ${state.movie.cast![index].characterName}", style: Theme.of(context).textTheme.headline5, maxLines: 1, overflow: TextOverflow.ellipsis,)
                              ],))
                            ],
                          ),
                        ),
                        itemCount: state.movie.cast!.length,
                      ),
                      title("Summary"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          state.movie.descriptionFull!,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w400, wordSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
                // the top bar
                Positioned(
                  top: 0,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                viewModel.onPressBackAction();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 28,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_add_outlined,
                                color: Colors.white,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                      viewModel.setStateToLoading();
                      viewModel.loadData(widget.movieId);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    ),
                    child: const Text("Try Again"))
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget info(String title, IconData icon) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(width: 2, color: MyTheme.gold),
          color: MyTheme.blackOne),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: MyTheme.gold,
            size: 30,
          ),
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )),
        ],
      ),
    ));
  }
}
