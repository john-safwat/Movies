import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/ServerException.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/UseCase/addToHistoryUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getMovieFullDetailsUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getRelatedMoviesUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieDetailsViewModel extends Cubit<BaseCubitState> {
  GetRelatedMoviesUseCase getRelatedMoviesUseCase ;
  GetMovieFullDetailsUseCase getMovieFullDetailsUseCase ;
  AddToHistoryUseCase addToHistoryUseCase;
  MovieDetailsViewModel(this.getRelatedMoviesUseCase , this.getMovieFullDetailsUseCase , this.addToHistoryUseCase):super(LoadingState());

  AppConfigProvider? provider;

  HomeScreenViewModel?homeScreenViewModel;
  void loadData(num? movieId)async{
    try{
      var movies =await getRelatedMoviesUseCase.invoke(movieId.toString());
      var uid = await provider!.getUid();
      var movie =await getMovieFullDetailsUseCase.invoke(movieId , uid);
      print(movie.isWatched);
      emit(DataLoadedState( movie ,movies!)) ;
    }catch(e){
      if(e is ServerException){
        emit(ErrorState(e.error));
      }else {
        emit(ErrorState(e.toString()));
      }
    }
  }

  void setStateToLoading(){
    emit(LoadingState());
  }

  void onPressBackAction(){
    emit(BackAction());
  }

  void goToDetailsScreen(Movies movie){
    emit(MovieDetailsAction(movie));
  }

  Future<void> lunchURL(String link , Movie movie)async{
    try{
      var url = Uri.parse(link);
      !await launchUrl(url ,  mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
              headers: <String, String>{'my_header_key': 'my_header_value'}));
      var uid = await provider!.getUid();
      var response =await addToHistoryUseCase.invoke(uid, movie.id!, movie.mediumCoverImage!, movie.largeCoverImage!, movie.rating! , movie.isWatched);
      movie.isWatched = true;
    }catch(e){
      if(e is ServerException){
        emit(ErrorState(e.error));
      }else {
        emit(ErrorState(e.toString()));
      }
    }
  }
}

class DataLoadedState extends BaseCubitState{
  Movie movie ;
  List<Movies> relatedMovies;
  DataLoadedState(this.movie ,this.relatedMovies);
}

class MovieDetailsAction extends BaseCubitState{
  Movies movie;
  MovieDetailsAction(this.movie);
}

class BackAction extends BaseCubitState{}
