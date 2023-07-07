import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Core/utils/DialogUtils.dart';
import 'package:mymoviesapp/Domain/UseCase/loginUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyTextFileds.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Login/LoginViewModel.dart';
import 'package:mymoviesapp/Presentation/Registration/RegistrationView.dart';
import 'package:mymoviesapp/Presentation/ResetPassword/ResetPasswordView.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';
  static const String path = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel = LoginViewModel(LoginUseCase(injectAuthRepository()));

  @override
  void initState() {
    super.initState();
    viewModel.provider = Provider.of<AppConfigProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.provider = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<LoginViewModel, BaseCubitState>(
        listener: (context, state) {
          if(state is GoToRegistrationScreenAction){
            context.goNamed(RegistrationScreen.routeName);
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
                posAction: viewModel.goToHomeScreen);
          }
          if (state is ShowErrorMessageState) {
            MyDialogUtils.showFailMessage(
                context: context,
                message: state.message,
                posActionTitle: "Try Again");
          }
          if (state is GoToHomeScreenAction) {
            GoRouter.of(context).goNamed(HomeTabView.routeName);
          }
          if(state is GoToResetPasswordScreenAction){
            GoRouter.of(context).pushNamed(ResetPasswordView.routeName);
          }
        },

        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Image.asset("assets/images/Logo.png", width: 150,),
                  Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          MyTextFormField(
                            "Email",
                            EvaIcons.email,
                            viewModel.emailValidation,
                            viewModel.emailController,
                            TextInputType.emailAddress,
                          ),
                          MyPasswordTextFormField(
                            "Password",
                            EvaIcons.lock,
                            viewModel.passwordValidation,
                            viewModel.passwordController,
                            TextInputType.visiblePassword,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: viewModel.goToResetPasswordScreen,
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                  child: Text("Forget Password" , style: Theme.of(context).textTheme.headline5,)
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                                onPressed: viewModel.login,
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
                                    "Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
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
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
