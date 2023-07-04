import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Core/utils/DialogUtils.dart';
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
              showMyModalBottomSheet(context);
            }
            if(state is ShowLoadingState){
              showLoadingDialog(context , "Creating Account ...");
            }
            if(state is HideLoadingState){
              context.pop();
            }
            if (state is InputWaiting){
              context.pop();
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

  Future<void> showMyModalBottomSheet(BuildContext context)async{
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent ,
      isScrollControlled: true,
      builder: (context) => Wrap(
        children: [
          ModalSheetWidget(
              viewModel.images,
              viewModel.image,
              viewModel.changeSelectedImage
          ),
        ],
      ),

    );
  }
}

class ModalSheetWidget extends StatefulWidget {
  ModalSheetWidget(this.images , this.selectedImage, this.changeSelectedImage,{super.key});
  // ScrollController scrollController ;
  List<String> images ;
  String selectedImage;
  Function changeSelectedImage;

  @override
  State<ModalSheetWidget> createState() => _ModalSheetWidgetState();
}

class _ModalSheetWidgetState extends State<ModalSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyTheme.blackTwo
      ),
      child:Column(
          children: [
            Text("Pick Avatar" , style: Theme.of(context).textTheme.headline3,),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20),
              // controller: widget.scrollController,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  setState(() {
                    widget.selectedImage = widget.images[index];
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: widget.selectedImage == widget.images[index] ? MyTheme.gray:MyTheme.blackTwo,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(widget.images[index] , width: 100)
                ),
              ),
              itemCount: widget.images.length,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))
                ),
                onPressed: (){
                  widget.changeSelectedImage(widget.selectedImage);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Confirm",
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}

