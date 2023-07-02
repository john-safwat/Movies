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
    return SafeArea(
      child: BlocProvider(
        create: (context) => viewModel,
        child: BlocConsumer<RegistrationViewModel , BaseCubitState>(
          listener: (context, state) {
            if(state is ShowModalBottomSheetAction){
              showMyModalBottomSheet(context , viewModel.images);
            }
          },
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Create Account"),
            ),
            body:GlowingOverscrollIndicator(
              color: MyTheme.gold,
              axisDirection: AxisDirection.down,
              child: SingleChildScrollView(

                // physics: const BouncingScrollPhysics(),
                child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0 ),
                child:  Column(
                    children: [
                      Stack(children: [
                        Image.asset(viewModel.image , width: 150,),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: viewModel.showModalBottomSheetState,
                            child: CircleAvatar(
                                backgroundColor: MyTheme.gold,
                                child: Icon(Icons.edit , color: MyTheme.white,)
                            ),
                          ),
                        ),
                      ]),
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
        ),
      ),
    );
  }

  Future<void> showMyModalBottomSheet(BuildContext context , List<String> images)async{
    showModalBottomSheet(
        context: context,
        backgroundColor: MyTheme.blackThree,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )
        ),
        builder: (context) => Container(

        ),
    );
  }
}

