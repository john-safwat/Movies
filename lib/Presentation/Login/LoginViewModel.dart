import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';
import 'package:mymoviesapp/Domain/UseCase/loginUseCase.dart';

class LoginViewModel extends Cubit<BaseCubitState>{

  LoginUseCase useCase ;
  LoginViewModel(this.useCase):super(InputWaiting());

  AppConfigProvider? provider;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  void login()async{
    if(formKey.currentState!.validate()){
      emit(ShowLoadingState("Signing You In"));
      try{
        var response = await useCase.invoke(emailController.text, passwordController.text);
        provider!.updateUid(response);
        emit(HideDialog());
        emit(ShowSuccessMessageState("Welcome Back"));
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

  void goToHomeScreen(){
    emit(GoToHomeScreenAction());
  }

  void goToRegistrationScreen(){
    emit(GoToRegistrationScreenAction());
  }
}

class InputWaiting extends BaseCubitState{}
class InvalidState extends BaseCubitState{}
class GoToRegistrationScreenAction extends BaseCubitState{}
class GoToHomeScreenAction extends BaseCubitState{}