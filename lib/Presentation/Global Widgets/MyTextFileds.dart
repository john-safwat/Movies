
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

class myTextFormField  extends StatelessWidget {

  String hint;
  IconData icon ;
  Function validation ;
  TextEditingController controller;
  TextInputType keyboardType;
  myTextFormField(this.hint , this.icon , this.validation, this.controller , this.keyboardType,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:const EdgeInsets.symmetric(horizontal:20, vertical: 10),
      child: TextFormField(
        textCapitalization:TextCapitalization.words,
        style: Theme.of(context).textTheme.headline6,
        validator: (value) => validation(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        cursorColor: MyTheme.gray,
        keyboardType: keyboardType,
        decoration: InputDecoration(

          contentPadding:const EdgeInsets.all(15),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.headline6,
          prefixIcon: Icon(
            icon,
            color: MyTheme.gray,
          ),
          filled: true,
          fillColor: MyTheme.blackOne,
          errorStyle:const TextStyle(
            fontSize: 14,
            color: Colors.red
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
          errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.red)
          ),
          disabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
          focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.red)
          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
        ),
      ),
    );
  }
}


class myPasswordTextFormField  extends StatefulWidget {

  String hint;
  IconData icon ;
  Function validation ;
  TextEditingController controller;
  TextInputType keyboardType;
  myPasswordTextFormField(this.hint , this.icon , this.validation, this.controller, this.keyboardType ,{super.key});

  @override
  State<myPasswordTextFormField> createState() => _myPasswordTextFormFieldState();
}

class _myPasswordTextFormFieldState extends State<myPasswordTextFormField> {
  bool showPassword = false ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      child: TextFormField(

        style: Theme.of(context).textTheme.headline6,
        validator: (value) => widget.validation(value),
        controller: widget.controller,
        obscureText: !showPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: MyTheme.gray,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(

          contentPadding:const EdgeInsets.all(15),
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.headline6,
          errorStyle:const TextStyle(
              fontSize: 14,
              color: Colors.red
          ),
          prefixIcon: Icon(
            widget.icon,
            color: MyTheme.gray,
          ),
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: (){
              setState(() {
                showPassword = !showPassword;
              });
            },
            child:showPassword? const Icon(Icons.visibility , color: MyTheme.gray,):const Icon(Icons.visibility_off , color: MyTheme.gray,),
          ),

          filled: true,
          fillColor: MyTheme.blackOne,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
          errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.red)
          ),
          disabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
          focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.red)
          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2 , color: MyTheme.blackOne)
          ),
        ),
      ),
    );
  }
}

