import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/UseCase/resetPasswordUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/updateUserDataUseCase.dart';

class EditProfileViewModel extends Cubit<BaseCubitState>{

  UpdateUserDataUseCase updateUserDataUseCase;
  ResetPasswordUseCase resetPasswordUseCase;

  EditProfileViewModel(this.user , this.updateUserDataUseCase , this.resetPasswordUseCase):super(InputWaiting());

  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  Users user;

  List<String> images = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];

  String image = '';

  void changeSelectedImage(String image){
    this.image = image;
    emit(InputWaiting());
  }

  void initData(){
    image = user.image;
    phone.text = user.phone;
    name.text= user.name;
  }

  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name){
    if (name.isEmpty){
      return "Name Can't be Empty";
    }else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)){
      return "Invalid Name";
    }else {
      return null;
    }
  }

  // validate on phone number
  String? phoneValidation(String input) {
    if (input.isEmpty) {
      return "Please Enter a Phone Number";
    } else if (!RegExp(
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
        .hasMatch(input)) {
      return "Please Enter a Valid Phone Number";
    }
    return null;
  }

  void resetPassword()async{
    if(formKey.currentState!.validate()){
      emit(ShowLoadingState("Sending Email"));
      try{
        var response =  await resetPasswordUseCase.invoke(user.email);
        emit(HideDialog());
        emit(ShowSuccessMessageState(response));
      }catch (e){
        emit(HideDialog());
        if (e is FirebaseAuthDataSourceException){
          emit(ShowErrorMessageState(e.errorMessage));
        }else if (e is FirebaseTimeoutException){
          emit(ShowErrorMessageState(e.error));
        }else {
          emit(ShowErrorMessageState(e.toString()));
        }
      }
    }
  }

  // registration to validate and send the data to data base
  void updateUserData()async{
    if(formKey.currentState!.validate()){
      emit(ShowLoadingState("Updating"));
      user.image = image;
      user.name = name.text;
      user.phone = phone.text;
      try {
        var response = await updateUserDataUseCase.invoke(user);
        emit(HideDialog());
        emit(ShowSuccessMessageState("Data Updated Successfully"));
      }catch (e){
        emit(HideDialog());
        if(e is FirebaseAuthDataSourceException){
          emit(ShowErrorMessageState(e.errorMessage));
        }else if (e is FirebaseTimeoutException){
          emit(ShowErrorMessageState(e.error));
        } else {
          emit(ShowErrorMessageState(e.toString()));
        }
      }
    }
  }

  void goToHomeScreen(){
    emit(GoToHomeScreenAction());
  }

}
class InputWaiting extends BaseCubitState{}
class GoToHomeScreenAction extends BaseCubitState{}
