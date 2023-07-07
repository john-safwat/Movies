import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoviesapp/Core/Base/BaseCubitState.dart';
import 'package:mymoviesapp/Core/DI/di.dart';
import 'package:mymoviesapp/Core/Providers/AppConfigProvieder.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Domain/UseCase/getUserDataUseCase.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:provider/provider.dart';

class ProfileTabView extends StatefulWidget {
  static const String routeName = 'ProfileTab';
  static const String path = '/ProfileTab';

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  ProfileTabViewModel viewModel = ProfileTabViewModel(GetUserDataUseCase(injectUserRepository()));
  @override
  void initState() {
    super.initState();
    viewModel.provider = Provider.of<AppConfigProvider>(context,listen: false);
    viewModel.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileTabViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<ProfileTabViewModel , BaseCubitState>(
        listener: (context, state) {},

        builder: (context, state) {
          if(state is LoadingState){
            return const Center(
              child: CircularProgressIndicator(
                color: MyTheme.gold,
              ),
            );
          } else if(state is ErrorState){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage , style: const TextStyle(color: Colors.white),),
                ElevatedButton(
                    onPressed: (){
                      viewModel.getUserData();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    ) ,
                    child:const Text(
                        "Try Again"
                    )
                )
              ],
            );
          }else if (state is UserLoadedState){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 30),
                  child: Row(
                    children: [
                      Image.asset(state.user.image),
                      const SizedBox(width: 20,),
                      Expanded(child: Text(state.user.name , style: Theme.of(context).textTheme.headline3,))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                      backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    ),
                    child: Text("Edit Profile" , style: Theme.of(context).textTheme.headline5,),
                  ),
                ),
              ],
            );
          }else {
            return Container();
          }
        },
      ),
    );
  }
}
