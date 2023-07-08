import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/Movie.dart';
import 'package:mymoviesapp/Domain/UseCase/getMovieFullDetailsUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getRelatedMoviesUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieDetailsViewModel extends Cubit<BaseCubitState> {
  GetRelatedMoviesUseCase getRelatedMoviesUseCase ;
  GetMovieFullDetailsUseCase getMovieFullDetailsUseCase ;
  MovieDetailsViewModel(this.getRelatedMoviesUseCase , this.getMovieFullDetailsUseCase):super(LoadingState());

  HomeScreenViewModel?homeScreenViewModel;
  void loadData(String movieId)async{
    try{
      var movies =await getRelatedMoviesUseCase.invoke(movieId.toString());
      var movie =await getMovieFullDetailsUseCase.invoke(movieId.toString());

      emit(DataLoadedState( movie ,movies!)) ;
    }catch (e){
      emit(ErrorState(e.toString()));
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

  Future<void> lunchURL(String link)async{
    try{
      var url = Uri.parse(link);
      !await launchUrl(url ,  mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
              headers: <String, String>{'my_header_key': 'my_header_value'}));
    }catch(e){
      e.toString();
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
