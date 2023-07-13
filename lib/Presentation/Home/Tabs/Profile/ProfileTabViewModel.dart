import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Providers/DataProvider.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseDatabaseExeption.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/UseCase/getHistoryUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getUserDataUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/getWishListDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTabViewModel extends Cubit<BaseCubitState>{

  GetUserDataUseCase getUserDataUseCase;
  GetHistoryUseCase getHistoryUseCase;
  GetWishListDataUseCase getWishListDataUseCase;
  ProfileTabViewModel(this.getUserDataUseCase , this.getHistoryUseCase , this.getWishListDataUseCase):super(LoadingState());

  HomeScreenViewModel? homeScreenViewModel ;
  AppConfigProvider? provider;
  DataProvider? dataProvider;

  void getData()async{
    emit(LoadingState());
    try{
      String uid = await provider!.getUid();
      var userResponse = await getUserDataUseCase.invoke(uid);
      var moviesResponse = await getHistoryUseCase.invoke(uid);
      var wishListResponse = await getWishListDataUseCase.invoke(uid);
      dataProvider!.watchHistory = moviesResponse;
      dataProvider!.wishList= wishListResponse;
      emit(DataLoadedState(userResponse , dataProvider!.watchHistory , dataProvider!.wishList));
    }catch (e){
      if(e is FirebaseDatabaseException){
        emit(ErrorState(e.errorMessage));
      }else {
        emit(ErrorState(e.toString()));
      }
    }
  }

  void goToDetailsScreen(num movie){
    emit(MovieDetailsAction(movie));
  }

  void onSignOutPress(String message){
    emit(ShowQuestionMessageState(message));
  }

  void signOut()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', '');
    emit(SignOutAction());
  }

}

class DataLoadedState extends BaseCubitState{
  Users user;
  List<Movies> historyMovies;
  List<Movies> wishlistMovies;
  DataLoadedState(this.user , this.historyMovies , this.wishlistMovies);
}

class ShowQuestionMessageState extends BaseCubitState{
  String message;
  ShowQuestionMessageState(this.message);
}
class SignOutAction extends BaseCubitState{}
