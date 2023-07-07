import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/DataProvider.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesByGenreUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';

class HomeTabViewModel extends Cubit<BaseCubitState>{
  GetMoviesDataUseCase getMoviesDataUseCase ;
  GetMoviesByGenreUseCase getMoviesByGenreUseCase ;
  HomeTabViewModel(this.getMoviesDataUseCase , this.getMoviesByGenreUseCase):super(LoadingState());

  DataProvider? provider ;
  HomeScreenViewModel? homeScreenViewModel;

  Future<void> readData()async{
    emit(LoadingState());
    if(provider!.movies != null){
      emit(MoviesLoadedState(provider!.movies,provider!.actionMovies, provider!.animationMovies, provider!.crimeMovies, provider!.dramaMovies));
    } else {
      try{

        final response = await Future.wait([
          getMoviesDataUseCase.doWork(),
          getMoviesByGenreUseCase.doWork("Drama"),
          getMoviesByGenreUseCase.doWork("Action"),
          getMoviesByGenreUseCase.doWork("Crime"),
          getMoviesByGenreUseCase.doWork("animation")
        ]);

        var movies = response[0];
        var dramaMovies = response[1];
        var actionMovies = response[2] ;
        var crimeMovies = response[3];
        var animationMovies = response[4];

        provider!.movies = movies;
        provider!.dramaMovies = dramaMovies;
        provider!.actionMovies = actionMovies;
        provider!.crimeMovies = crimeMovies;
        provider!.animationMovies = animationMovies;

        if(movies == null || dramaMovies == null || animationMovies == null || actionMovies == null ||crimeMovies == null){
          emit(ErrorState("Couldn't Load The Data"));
        }else{
          emit(MoviesLoadedState(movies, actionMovies, animationMovies, crimeMovies, dramaMovies));
        }
      }catch(e){
        emit(ErrorState(e.toString()));
      }
    }
  }

  void setStateToLoading(){
    emit(LoadingState());
  }

  void goToDetailsScreen(Movies movie){
    emit(MovieDetailsAction(movie));
  }
}

class MoviesLoadedState extends BaseCubitState {
  List<Movies>? movies ;
  List<Movies>? actionMovies ;
  List<Movies>? dramaMovies ;
  List<Movies>? crimeMovies ;
  List<Movies>? animationMovies ;

  MoviesLoadedState(this.movies , this.actionMovies , this.animationMovies , this.crimeMovies , this.dramaMovies);
}
class MovieDetailsAction extends BaseCubitState{
  Movies movie;
  MovieDetailsAction(this.movie);
}