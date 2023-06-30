import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/UseCase/getMoviesByGenreToBrowseUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';

class BrowseTabViewModel extends Cubit<BaseCubitState>{
  List<String> genres = [
    'Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama',
    'Family', 'Fantasy', 'Film Noir', 'History', 'Horror', 'Music', 'Musical', 'Mystery', 'Romance',
    'Sci-Fi', 'Short Film', 'Sport', 'Superhero', 'Thriller', 'War', 'Western',
  ];
  int selectedIndex = 0;
  int pageNumber = 1;
  List<Movies> movies = [];
  GetMoviesByGenreToBrowseUseCase useCase ;
  BrowseTabViewModel(this.useCase):super(LoadingState());

  ScrollController controller = ScrollController();

  HomeScreenViewModel? homeScreenViewModel;

  Future<void> getMoviesByGenre(String genre , int pageNumber)async{
    try {
      var response = await useCase.getMoviesToBrowse(genre , pageNumber);
      if(response == null){
        emit(ErrorState("No Movies To Load"));
      }else{
        movies.addAll(response);
        this.pageNumber++;
        emit(MoviesLoadedState());
      }
    }catch(e){
      emit(ErrorState(e.toString()));
    }
  }

  void changeToLoadingState(){
    emit(LoadingState());
  }

  void goToDetailsScreen(Movies movie){
    emit(MovieDetailsAction(movie));
  }

  void changeTap(int index){
    selectedIndex = index;
    pageNumber = 1;
    movies = [];
    emit(LoadingState());
    getMoviesByGenre(genres[selectedIndex], pageNumber);
  }
}

class MoviesLoadedState extends BaseCubitState {}
class MovieDetailsAction extends BaseCubitState{
  Movies movie;
  MovieDetailsAction(this.movie);
}