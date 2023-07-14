import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Core/utils/DialogUtils.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/UseCase/resetPasswordUseCase.dart';
import 'package:mymoviesapp/Domain/UseCase/updateUserDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyBottomSheet.dart';
import 'package:mymoviesapp/Presentation/Global%20Widgets/MyTextFileds.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/EditProfileScreen/EditProfileViewModel.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';

class EditProfileView extends StatefulWidget {

  Users user;
  EditProfileView({required this.user,super.key});
  static const String routeName = 'EditProfile';
  static const String path = '/EditProfile';

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late EditProfileViewModel viewModel = EditProfileViewModel(
    widget.user,
    UpdateUserDataUseCase(injectUserRepository()),
    ResetPasswordUseCase(injectUserRepository())
  );

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<EditProfileViewModel , BaseCubitState>(
        listener: (context, state) {
          if (state is HideDialog) {
            MyDialogUtils.hideDialog(context);
          } else if (state is ShowLoadingState) {
            MyDialogUtils.showLoadingDialog(context, state.message);
          } else if (state is ShowSuccessMessageState) {
            MyDialogUtils.showSuccessMessage(
                context: context,
                message: state.message,
                posActionTitle: "Ok",
                posAction: viewModel.goToHomeScreen);
          } else if (state is ShowErrorMessageState) {
            MyDialogUtils.showFailMessage(
                context: context,
                message: state.message,
                posActionTitle: "Try Again");
          }else if (state is GoToHomeScreenAction) {
            GoRouter.of(context).goNamed(HomeTabView.routeName);
          } else if (state is InputWaiting) {
            context.pop();
          }
        },

        builder:(context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile" , style: Theme.of(context).textTheme.displayMedium,),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        viewModel.image,
                        width: 150,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              viewModel.image =  viewModel.images[index] ;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: viewModel.image == viewModel.images[index]
                                    ? MyTheme.gray
                                    : MyTheme.blackTwo,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(viewModel.images[index], width: 100)),
                        ),
                        itemCount: viewModel.images.length,
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
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
                            "Phone Number",
                            EvaIcons.phone,
                            viewModel.phoneValidation,
                            viewModel.phone,
                            TextInputType.phone),
                        Row(
                          children: [
                            SizedBox(width: 15,),
                            TextButton(onPressed: viewModel.resetPassword, child: Text("Reset Password" ,style: Theme.of(context).textTheme.displaySmall ,textAlign: TextAlign.start,) ,),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(20),
                          child: ElevatedButton(
                              onPressed: viewModel.updateUserData,
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
                                  "Update Data",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
