import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseDatabaseExeption.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/UseCase/getUserDataUseCase.dart';

class ProfileTabViewModel extends Cubit<BaseCubitState>{

  GetUserDataUseCase useCase;
  ProfileTabViewModel(this.useCase):super(LoadingState());
  AppConfigProvider? provider;

  void getUserData()async{
    emit(LoadingState());
    try{
      String uid = await provider!.getUid();
      var response = await useCase.invoke(uid);
      emit(UserLoadedState(response));
    }catch (e){
      if(e is FirebaseDatabaseException){
        emit(ErrorState(e.errorMessage));
      }else {
        emit(ErrorState(e.toString()));
      }
    }
  }
}

class UserLoadedState extends BaseCubitState{
  Users user;
  UserLoadedState(this.user);
}
