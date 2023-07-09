import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Domain/Exceptions/ServerException.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/UseCase/getSearchResultsUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';

class SearchTabViewModel extends Cubit<BaseCubitState>{
  GetSearchResultsUseCase useCase ;
  SearchTabViewModel(this.useCase) : super(EmptyListState());

  HomeScreenViewModel? homeScreenViewModel;

  Future<void> getSearchResults(String keyword)async{
    emit(LoadingState());
    if(keyword.isNotEmpty){
      try{
        if(keyword == 'الراجل اللي يابختة'){
          keyword = 'iron man';
        }
        var response = await useCase.getSearchResults(keyword);
        if(response == null){
          emit(ErrorState("No Movies To Load"));
        }else{
          emit(MoviesLoadedState(response));
        }
      }catch(e){
        if(e is ServerException){
          emit(ErrorState(e.error));
        }else {
          emit(ErrorState(e.toString()));
        }
      }
    }else{
      emit(EmptyListState());
    }
  }

  void goToDetailsScreen(Movies movie){
    emit(MovieDetailsAction(movie));
  }

}

class EmptyListState extends BaseCubitState{}

class MoviesLoadedState extends BaseCubitState {
  List<Movies> movies ;
  MoviesLoadedState(this.movies);
}
class MovieDetailsAction extends BaseCubitState{
  Movies movie;
  MovieDetailsAction(this.movie);
}