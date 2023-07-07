import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';
import 'package:mymoviesapp/Domain/UseCase/resetPasswordUseCase.dart';

class ResetPasswordViewModel extends Cubit<BaseCubitState>{

  ResetPasswordUseCase useCase ;

  ResetPasswordViewModel(this.useCase):super(InputWaiting());

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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

  void resetPassword()async{
    if(formKey.currentState!.validate()){
      emit(ShowLoadingState("Sending Email"));
      try{
        var response =  await useCase.invoke(emailController.text);
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

  void goToRegistrationScreen(){
    emit(GoToRegistrationScreenAction());
  }

  void goToLoginScreen(){
    emit(GoToLoginScreenAction());
  }

}
class InputWaiting extends BaseCubitState{}
class GoToRegistrationScreenAction extends BaseCubitState{}
class GoToLoginScreenAction extends BaseCubitState{}
