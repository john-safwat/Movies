import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/signupUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyTextFileds.dart';
import 'package:mymoviesapp/Presentation/Registration/RefistrationViewModel.dart';
import 'package:unicons/unicons.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "registration";
  static const String path = "/registration";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  RegistrationViewModel viewModel = RegistrationViewModel(SignupUseCase(injectAuthRepository()));


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<RegistrationViewModel , BaseCubitState>(
        listener: (context, state) {

        },
        builder: (context, state) => Scaffold(
          body:SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0 ),
            child:  Column(
                children: [
                  const SizedBox(height: 20,),
                  Image.asset('assets/images/Logo.png' , width: 150,),
                  Text("Create Account" , style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.bold),),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        myTextFormField("Name" , Icons.badge_outlined , viewModel.nameValidation , viewModel.name , TextInputType.name),
                        myTextFormField("Email" , Icons.email_outlined , viewModel.emailValidation , viewModel.email , TextInputType.emailAddress),
                        myPasswordTextFormField("Password" , Icons.lock_outline_rounded , viewModel.passwordValidation , viewModel.password , TextInputType.visiblePassword),
                        myPasswordTextFormField("Re-Password" , Icons.lock_outline_rounded , viewModel.passwordValidation , viewModel.passwordConfirmation , TextInputType.visiblePassword),
                        myTextFormField("Phone Number" , UniconsLine.dialpad_alt , viewModel.phoneValidation , viewModel.phone , TextInputType.phone),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: viewModel.register,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Create Account",
                                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Have Account ?" , style: Theme.of(context).textTheme.headline5,),
                            TextButton(
                              onPressed: (){},
                              child: Text("Login" , style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),)
                            )
                          ],
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

