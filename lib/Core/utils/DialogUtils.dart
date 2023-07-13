import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

class MyDialogUtils {
  static Future<void> showLoadingDialog(BuildContext context, String message) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: MyTheme.blackOne,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              contentPadding: EdgeInsets.all(30),
              content: Row(
                children: [
                  CircularProgressIndicator(
                    color: MyTheme.gold,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
            ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }

  static hideDialog(BuildContext context){
    context.pop();
  }

  static showFailMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      actionList.add(
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.blackOne),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 2, color: MyTheme.gold),
                      )
                  )
              ),
              onPressed: (){
                context.pop();
                if (negativeAction != null){
                  negativeAction();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(negativeActionTitle,style: Theme.of(context).textTheme.headline5,),
              ),
            ),
          )
      );
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(SizedBox(width: 20,));
      }
      actionList.add(
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    )
                ),
                onPressed: (){
                  context.pop();
                  if (posAction != null){
                    posAction();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(posActionTitle,style: Theme.of(context).textTheme.headline5,),
                )
            ),
          )
      );
    }


    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: MyTheme.blackOne,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(1000)),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }



  static showSuccessMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      actionList.add(
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.blackOne),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 2, color: MyTheme.gold),
                        )
                    )
                ),
              onPressed: (){
                  context.pop();
                  if (negativeAction != null){
                    negativeAction();
                  }
                },
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(negativeActionTitle,style: Theme.of(context).textTheme.headline5,),
                ),
            ),
          )
      );
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(SizedBox(width: 20,));
      }
      actionList.add(
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    )
                ),
                onPressed: (){
                  context.pop();
                  if (posAction != null){
                    posAction();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(posActionTitle,style: Theme.of(context).textTheme.headline5,),
                )
            ),
          )
      );
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: MyTheme.blackOne,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      EvaIcons.checkmarkCircle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }

  static showQuestionMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      actionList.add(
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.blackOne),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 2, color: MyTheme.gold),
                      )
                  )
              ),
              onPressed: (){
                context.pop();
                if (negativeAction != null){
                  negativeAction();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(negativeActionTitle,style: Theme.of(context).textTheme.headline5,),
              ),
            ),
          )
      );
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(SizedBox(width: 20,));
      }
      actionList.add(
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    )
                ),
                onPressed: (){
                  context.pop();
                  if (posAction != null){
                    posAction();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(posActionTitle,style: Theme.of(context).textTheme.headline5,),
                )
            ),
          )
      );
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: MyTheme.blackOne,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: MyTheme.gold,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      EvaIcons.questionMark,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }
}
