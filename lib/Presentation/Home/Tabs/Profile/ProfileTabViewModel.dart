import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseDatabaseExeption.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/UseCase/getHistoryUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getUserDataUseCase.dart';

class ProfileTabViewModel extends Cubit<BaseCubitState>{

  GetUserDataUseCase getUserDataUseCase;
  GetHistoryUseCase getHistoryUseCase;
  ProfileTabViewModel(this.getUserDataUseCase , this.getHistoryUseCase):super(LoadingState());
  AppConfigProvider? provider;

  void getUserData()async{
    emit(LoadingState());
    try{
      String uid = await provider!.getUid();
      var userResponse = await getUserDataUseCase.invoke(uid);
      var moviesResponse = await getHistoryUseCase.invoke(uid);

      emit(DataLoadedState(userResponse , moviesResponse));
    }catch (e){
      if(e is FirebaseDatabaseException){
        emit(ErrorState(e.errorMessage));
      }else {
        emit(ErrorState(e.toString()));
      }
    }
  }

  void goToDetailsScreen(String id){
    emit(GoToDetailsScreenAction(id));
  }

}

class DataLoadedState extends BaseCubitState{
  Users user;
  List<Movies> movies;
  DataLoadedState(this.user , this.movies);
}

class GoToDetailsScreenAction extends BaseCubitState{
  String movieId;
  GoToDetailsScreenAction(this.movieId);
}
