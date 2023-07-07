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
          }else {
            return Container();
          }
        },
      ),
    );
  }
}
