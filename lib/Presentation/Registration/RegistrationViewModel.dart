import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseDatabaseExeption.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';
import 'package:mymoviesapp/Domain/UseCase/signupUseCase.dart';

class RegistrationViewModel extends Cubit<BaseCubitState>{

  SignupUseCase useCase;
  RegistrationViewModel(this.useCase):super(InputWaiting());

  AppConfigProvider? provider ;

  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  TextEditingController phone = TextEditingController();

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

  String image = "assets/images/avatar1.png";

  void showModalBottomSheetState(){
    emit(ShowModalBottomSheetAction());
  }

  void changeSelectedImage(String image){
    this.image = image;
    emit(InputWaiting());
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
  // validate on the email form
  String? emailValidation(String input) {
    if (input.isEmpty) {
      return "The Email Can't Be Empty";
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(input)) {
      return "Please Enter A Valid Email";
    }
    return null;
  }
  // validate the password is not less than 8 chars
  String? passwordValidation(String input) {
    if (input.isEmpty) {
      return "The Password Can't Be Empty";
    } else if (input.length < 8) {
      return "The Password Must be More Than 8 Characters";
    }
    return null;
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

  // registration to validate and send the data to data base
  void register()async{
    if(password.text == passwordConfirmation.text){
      if(formKey.currentState!.validate()){
        emit(ShowLoadingState("Creating Your Account"));
        try {
          var response = await useCase.invoke(
              name: name.text,
              email: email.text,
              password: password.text,
              image: image,
              phone: phone.text);
          emit(HideDialog());
          emit(ShowSuccessMessageState("Account Created Successfully"));
          provider!.updateUid(response);
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
    }else{
      emit(HideDialog());
      emit(ShowErrorMessageState("Passwords Doesn't Match"));
    }
  }

  void goToHomeScreen(){
    emit(GoToHomeScreenAction());
  }

  void goToLoginScreen(){
    emit(GoToLoginScreenAction());
  }
}


class InputWaiting extends BaseCubitState{}
class GoToHomeScreenAction extends BaseCubitState{}
class GoToLoginScreenAction extends BaseCubitState{}
class ShowModalBottomSheetAction extends BaseCubitState{}
