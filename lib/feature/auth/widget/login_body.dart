import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/core/services/shared_pref.dart';
import 'package:php_note/core/utils/widget/custom_button.dart';
import 'package:php_note/core/utils/widget/text_form_filed.dart';
import 'package:php_note/core/utils/widget/valid.dart';
import 'package:php_note/feature/auth/controller/auth_cubit.dart';

import '../../../core/utils/widget/custom_snack_bar.dart';

class loginScr extends StatefulWidget {
   loginScr({super.key});

  @override
  State<loginScr> createState() => _loginScrState();
}

class _loginScrState extends State<loginScr> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState>key=GlobalKey();
  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(builder: (context,state){
      var cubit=AuthCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body:Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Image.asset('assets/note_logo.png',height: 200,),
                  defaultTextForm(controller: emailController, validator: (String?value){
                   return validInput(value!, 11, 40);
                  },preficon:Icons.email,hint:'email'),
                  SizedBox(height: 20,),
                  defaultTextForm(controller: passwordController, validator: (String?value){
                   return validInput(value!, 5, 40);

                  },preficon:Icons.password,hint: 'password'),
                  SizedBox(height: 30,),
                  CustomButton(onPressed: ()async{
                    String email=emailController.text;
                    String password=passwordController.text;
                    if(key.currentState!.validate()){

                    await cubit.login(email: email,password: password);
                  }},text: 'Login',textStyle: TextStyle(fontSize: 20,color: Colors.white),loading: state is AuthLoading?true:false,),
                  Row(children: [
                    SizedBox(width: 10,),
                    Text('Don\'t have an account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed("register");

                    },child: Text('Register',style: TextStyle(color: Colors.blue),),)
                  ],)



                ],
              ),
            ),
          ),
        ),

      );
    }, listener: (context,state){
      if(state is AuthSuccess){
        SharedPref.setString(userId,state.response['data']['id'].toString());
        SharedPref.setString(userEmail,state.response['data']['email'].toString());
        SharedPref.setString(userName,state.response['data']['username'].toString());

        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      }
      if(state is AuthFailure){
        customSnackBar(context,"user doesn't exist",true,Colors.red);

      }

    });
  }
}
