import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/utils/DialogUtils.dart';
import 'package:mymoviesapp/Domain/UseCase/resetPasswordUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyTextFileds.dart';
import 'package:mymoviesapp/Presentation/Login/LoginView.dart';
import 'package:mymoviesapp/Presentation/Registration/RegistrationView.dart';
import 'package:mymoviesapp/Presentation/ResetPassword/ResetPasswordViewModel.dart';

import '../../Core/Theme/Theme.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  static const String path = '/ResetPassword';
  static const String routeName = 'ResetPassword';

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ResetPasswordViewModel viewModel = ResetPasswordViewModel(ResetPasswordUseCase(injectUserRepository()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<ResetPasswordViewModel , BaseCubitState>(
        listener: (context, state) {
          if(state is GoToRegistrationScreenAction){
            context.goNamed(RegistrationScreen.routeName);
          }
          if(state is GoToLoginScreenAction){
            context.goNamed(LoginScreen.routeName);
          }
          if (state is HideDialog) {
            MyDialogUtils.hideDialog(context);
          }
          if (state is ShowLoadingState) {
            MyDialogUtils.showLoadingDialog(context, state.message);
          }
          if (state is ShowSuccessMessageState) {
            MyDialogUtils.showSuccessMessage(
                context: context,
                message: state.message,
                posActionTitle: "Ok",
                posAction: viewModel.goToLoginScreen);
          }
          if (state is ShowErrorMessageState) {
            MyDialogUtils.showFailMessage(
                context: context,
                message: state.message,
                posActionTitle: "Try Again");
          }
        },


        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Forget Password"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/Forgot password-pana.png' ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Please Enter your Email Address To Receive a Recovery Link" , style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center,),
                ),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      MyTextFormField("Email", EvaIcons.email, viewModel.emailValidation, viewModel.emailController, TextInputType.emailAddress),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: viewModel.resetPassword,
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(
                                    MyTheme.gold),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Send Mail",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account ?",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextButton(
                        onPressed: viewModel.goToRegistrationScreen,
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          "Create One",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
