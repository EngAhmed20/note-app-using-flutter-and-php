import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/api/crud.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/core/utils/widget/custom_snack_bar.dart';
import 'package:php_note/core/utils/widget/valid.dart';
import 'package:php_note/feature/auth/controller/auth_cubit.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../../core/utils/widget/text_form_filed.dart';

class SignupScr extends StatefulWidget {
  SignupScr({super.key});

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;


  GlobalKey<FormState>key=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
        builder: (context,state){
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
                  defaultTextForm(controller: nameController, validator: (String?value){
                    return validInput(value!,3, 18);

                  },preficon:Icons.person,hint: 'name'),
                  const SizedBox(height: 20,),
                  defaultTextForm(controller: emailController, validator: (String?value){
                    return validInput(value!,9, 40);
                  },preficon:Icons.email,hint:'email'),
                  const SizedBox(height: 20,),
                  defaultTextForm(controller: passwordController, validator: (String?value){
                    return validInput(value!,6, 12);
                  },preficon:Icons.password,hint: 'password'),
                  const  SizedBox(height: 30,),
                  CustomButton(onPressed: ()async{
                    String name=nameController.text;
                    String email=emailController.text;
                    String password=passwordController.text;

                    if(key.currentState!.validate()){
                      await cubit.signUp(name: name, email: email, pass: password);
                    }

                  },text: 'Register',textStyle: TextStyle(fontSize: 20,color: Colors.white),loading: state is AuthLoading?true:false,),



                ],
              ),
            ),
          ),
        ),

      );
    },
        listener: (context,state){
          if(state is AuthSuccess){
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          }
          if(state is AuthFailure){
           customSnackBar(context,state.errorMessage,true,Colors.red);

          }
        });
  }
}