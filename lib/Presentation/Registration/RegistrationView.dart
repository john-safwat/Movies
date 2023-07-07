import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Core/utils/DialogUtils.dart';
import 'package:mymoviesapp/Domain/UseCase/signupUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyTextFileds.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Login/LoginView.dart';
import 'package:mymoviesapp/Presentation/Registration/RegistrationViewModel.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "registration";
  static const String path = "/registration";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationViewModel viewModel =
      RegistrationViewModel(SignupUseCase(injectAuthRepository()));

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
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<RegistrationViewModel, BaseCubitState>(
        listener: (context, state) {
          if (state is ShowModalBottomSheetAction) {
            showMyModalBottomSheet(context);
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
          if (state is GoToLoginScreenAction) {
            GoRouter.of(context).goNamed(LoginScreen.routeName);
          }
          if (state is InputWaiting) {
            context.pop();
          }
        },
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create  ",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Image.asset(
                        "assets/images/Logo.png",
                        height: 30,
                      ),
                      Text(
                        "  Account",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                  Stack(children: [
                    Image.asset(
                      viewModel.image,
                      width: 150,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: viewModel.showModalBottomSheetState,
                        child: CircleAvatar(
                            backgroundColor: MyTheme.gold,
                            child: Icon(
                              Icons.edit,
                              color: MyTheme.white,
                            )),
                      ),
                    ),
                  ]),
                  Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextFormField(
                              "Name",
                              EvaIcons.person,
                              viewModel.nameValidation,
                              viewModel.name,
                              TextInputType.name),
                          MyTextFormField(
                              "Email",
                              EvaIcons.email,
                              viewModel.emailValidation,
                              viewModel.email,
                              TextInputType.emailAddress),
                          MyPasswordTextFormField(
                              "Password",
                              EvaIcons.lock,
                              viewModel.passwordValidation,
                              viewModel.password,
                              TextInputType.visiblePassword),
                          MyPasswordTextFormField(
                              "Re-Password",
                              EvaIcons.lock,
                              viewModel.passwordValidation,
                              viewModel.passwordConfirmation,
                              TextInputType.visiblePassword),
                          MyTextFormField(
                              "Phone Number",
                              EvaIcons.phone,
                              viewModel.phoneValidation,
                              viewModel.phone,
                              TextInputType.phone),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                                onPressed: viewModel.register,
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
                                    "Create Account",
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
                                "Already Have Account ?",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              TextButton(
                                  onPressed: viewModel.goToLoginScreen,
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                  child: Text(
                                    "Login",
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

  Future<void> showMyModalBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Wrap(
        children: [
          ModalSheetWidget(
              viewModel.images, viewModel.image, viewModel.changeSelectedImage),
        ],
      ),
    );
  }
}

// the widget in the bottom sheet
class ModalSheetWidget extends StatefulWidget {
  ModalSheetWidget(this.images, this.selectedImage, this.changeSelectedImage,
      {super.key});
  // ScrollController scrollController ;
  List<String> images;
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
          borderRadius: BorderRadius.circular(20), color: MyTheme.blackTwo),
      child: Column(
        children: [
          Text(
            "Pick Avatar",
            style: Theme.of(context).textTheme.headline3,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20),
            // controller: widget.scrollController,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedImage = widget.images[index];
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: widget.selectedImage == widget.images[index]
                        ? MyTheme.gray
                        : MyTheme.blackTwo,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(widget.images[index], width: 100)),
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
                  ))),
              onPressed: () {
                widget.changeSelectedImage(widget.selectedImage);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Confirm",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
