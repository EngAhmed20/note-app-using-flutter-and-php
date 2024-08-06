import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant.dart';
import '../../../core/services/shared_pref.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../../core/utils/widget/custom_snack_bar.dart';
import '../../../core/utils/widget/text_form_filed.dart';
import '../../../core/utils/widget/valid.dart';
import '../controller/home_cubit.dart';

class EditNote extends StatefulWidget {
  EditNote(
      {super.key,
      required this.content,
      required this.title,
        required this.img,
      required this.noteId});
  String content, title, noteId,img;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  GlobalKey<FormState> editKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    contentController.text = widget.content;
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            appBar: AppBar(title: const Text('Edit Note',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            centerTitle: true,
            ),

            body: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,

              ),
              child: SingleChildScrollView(
                child: Form(
                  key: editKey,
                  child: Column(
                     children: [
                       SizedBox(
                         height: 50,
                       ),
                       Stack(
                         children: [
                           SizedBox(
                             height: 220,
                             child: ClipRRect(
                                 borderRadius: BorderRadius.circular(20),
                                 child: Image.network('$imgRoot/${widget.img}')),
                           ),
                           Positioned(
                             right: 0,
                             child: InkWell(
                               onTap: (){
                                 print(widget.img.toString());
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
                                 cubit.selectNewNoteImg();

                               },
                               child: CircleAvatar(
                                 child: Icon(Icons.replay),
                               ),
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 20,),
                       defaultTextForm(
                           controller: titleController,
                           validator: (String? value) {
                             validInput(value!, 3, 30);
                           },
                           preficon: Icons.title,
                           textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                           hint: 'title'),
                       SizedBox(
                         height: 20,
                       ),
                       defaultTextForm(
                           controller: contentController,
                           validator: (String? value) {
                             validInput(value!, 5, 100);
                           },
                           preficon: Icons.content_paste,
                           hint: 'content',
                           textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
                           maxLines: 6),
                       SizedBox(
                         height: 30,
                       ),
                       CustomButton(
                           onPressed: () async{
                             if(editKey.currentState!.validate()){
                               if (cubit.changeImg){
                                 await cubit.editNoteImage(SharedPref.getString(userId), titleController.text, contentController.text, widget.noteId ,widget.img.toString(),cubit.file);


                               }
                               await cubit.editNote(SharedPref.getString(userId), titleController.text, contentController.text, widget.noteId ,widget.img.toString());
                             }
                           },
                           text: 'Edit note',
                           textStyle:
                               TextStyle(fontSize: 20, color: Colors.white)),
                       SizedBox(
                         height: 20,
                       ),
                     ],
                   ),
                ),
              ),
            ));
      },
      listener: (context, state) {
        if(state is EditNoteSuccess){
          Navigator.of(context).pop();
        }
        if(state is EditNoteError){
         // customSnackBar(context, 'please try again',true,Colors.red);
        }
      },
    );
  }
}
