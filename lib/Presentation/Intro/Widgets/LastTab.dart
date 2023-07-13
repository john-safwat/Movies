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
                child: Text(
                  "See all Movies Details",
                  style: Theme.of(context).textTheme.displayLarge
                ),
              ),
              Image.asset('assets/images/image3_splash.png', width: MediaQuery.of(context).size.width * 0.8,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Watch What Ever You Want And Manage Watch List  ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),

                child: ElevatedButton(
                    onPressed: (){
                      changeIndexCallBack(3);

                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(MyTheme.white),
                        shape:MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))
                    ),
                    child: Text(
                      "Finish",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: MyTheme.gold)
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: (){
                      changeIndexCallBack(1);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side:const BorderSide(color: Colors.white ,width: 3)
                        ))
                    ),
                    child:  Text(
                      "Back",
                      style:Theme.of(context).textTheme.displayLarge
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
                    const SizedBox(width: 10,),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyTheme.blackFour
                      ),
                    ),
                    const SizedBox(width: 10,),
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
