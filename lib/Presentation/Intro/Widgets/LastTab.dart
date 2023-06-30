import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

class LastTab extends StatelessWidget {
  Function changeIndexCallBack ;
  LastTab({required this.changeIndexCallBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/shape3.png")
          ),
          Column(
            children: [
              Container(
                margin:const EdgeInsets.all(30),
                alignment: Alignment.topCenter,
                child: const Text(
                  "See all Movies Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Image.asset('assets/images/image3_splash.png', width: MediaQuery.of(context).size.width * 0.8,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Watch What Ever You Want And Manage Watch List  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: (){
                      changeIndexCallBack(3);

                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(MyTheme.white),
                        shape:MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))
                    ),
                    child: const Text(
                      "Finish",
                      style: TextStyle(
                          color: MyTheme.gold,
                          fontSize: 24
                      ),
                    )
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: (){
                      changeIndexCallBack(1);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side:const BorderSide(color: Colors.white ,width: 3)
                        ))
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 24
                      ),
                    )
                ),
              ),
              // the three points in the end
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyTheme.blackFour
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyTheme.blackFour
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyTheme.white
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
