import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';
import 'package:mymoviesapp/Presentation/Home/HomeScreenView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Home/HomeTabView.dart';
import 'package:mymoviesapp/Presentation/Home/Tabs/Search/SearchTabView.dart';
import 'package:mymoviesapp/Presentation/Login/LoginView.dart';
import 'package:mymoviesapp/Presentation/Registration/RegistrationView.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = 'welcomeScreen';
  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          Image.asset('assets/images/Logo.png'),
          const Text("Welcome" , style: TextStyle(
            color: Colors.white ,
            fontWeight: FontWeight.w900,
            fontSize: 35,
            letterSpacing: 3
          ),),
          const SizedBox(height: 30,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              onPressed: (){
                GoRouter.of(context).goNamed(LoginScreen.routeName);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(width: 5 , color: MyTheme.gold)
                  )
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline3!,
                ),
              )
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
                onPressed: (){
                  GoRouter.of(context).goNamed(RegistrationScreen.routeName);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.backGroundColor),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 2 , color: MyTheme.gold)
                      )
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                )
            ),
          ),

        ],
      ),
    );
  }
}
