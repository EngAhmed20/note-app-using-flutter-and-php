import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:php_note/core/utils/widget/custom_snack_bar.dart';
import 'package:php_note/core/utils/widget/text_form_filed.dart';
import 'package:php_note/core/utils/widget/valid.dart';
import 'package:php_note/feature/home/controller/home_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../constant.dart';
import '../../../core/services/shared_pref.dart';
import '../../../core/utils/widget/custom_button.dart';

class addNoteScr extends StatefulWidget {
   addNoteScr({super.key});

  @override
  State<addNoteScr> createState() => _addNoteScrState();
}

class _addNoteScrState extends State<addNoteScr> {
  TextEditingController titleController=TextEditingController();

  TextEditingController contentController=TextEditingController();

  GlobalKey<FormState>key=GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return Padding(
          padding:  EdgeInsets.only(left: 16,right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  defaultTextForm(controller: titleController, validator: (String?value){
                    validInput(value!, 3, 30);

                  },preficon:Icons.title,hint:'title'),
                  SizedBox(height: 20,),
                  defaultTextForm(controller: contentController, validator: (String?value){
                   validInput(value!, 5, 100);
                  },preficon:Icons.content_paste,hint: 'content',maxLines: 3),
                  SizedBox(height: 30,),
                  IconButton(onPressed: (){
                    showModalBottomSheet(context: context, builder:(context){
                      return Container(height: 100,child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(onTap: ()async{
                            await cubit.uploadImage(ImageSource.gallery);
                          },
                            child: Container(width: double.infinity,alignment: Alignment.center,
                                child: const Text('Gallery',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),)),
                          ),
                          const SizedBox(height:20,),
                          InkWell(onTap: ()async{
                            await cubit.uploadImage(ImageSource.camera);
                          },
                            child: Container(alignment: Alignment.center,width: double.infinity,
                                child: const Text('Camera',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),)),
                          )
                        ],
                      ),);
                    });

                  },icon: Icon(Icons.image,size: 40,color: Colors.red,),),
                 const  SizedBox(height: 20,),
                  CustomButton(onPressed: ()async{ if(key.currentState!.validate()){
                    if(cubit.file==null){
                       AwesomeDialog(context:context,title:"Error",body:Text('plese Select a Picture'));
                    }
                    await cubit.addNote(SharedPref.getString(userId), titleController.text,contentController.text,cubit.file);


                  }},text: 'Save note',textStyle: const TextStyle(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 20,),






                ],
              ),
            ),
          ),

        );

      },
      listener: (context,state){
        if (state is AddNoteSuccess) {
          Navigator.of(context).pop();
        }
        if (state is AddNoteError) {
          customSnackBar(context, state.errMsg,true,Colors.red,);
        }
      },
    );
  }
}
