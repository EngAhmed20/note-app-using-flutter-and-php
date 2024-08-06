import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:php_note/api/crud.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/core/services/shared_pref.dart';
import 'package:php_note/feature/model/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._crud,) : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);
  CRUD _crud;
  dynamic? notes;
  NoteModel? noteModel;

  Future<void>getAllNotes(String userId)async{
    emit(HomeGetNoteLoading());
    var response=await _crud.postRequest(getNotesLink, {
      'userid':userId,

    });
    if(response['status']=="success")
      {
         notes= response;
         noteModel=NoteModel.fromJson(response);
        print(noteModel);
        print("notes ${notes['data'][0]['notes_title']}");
       emit(HomeGetNoteSuccess(response: response));
      }else{
      emit(HomeGetNoteError(errMsg: response['status']));

    }
  }
  Future<void>addNote(String userId,String title,String content,File? noteImg)async{
    emit(AddNoteLoading());
    var response=await _crud.postReqWithFile(addNotesLink, {
      'userid':userId,
      'content':content,
      'title':title,

    },noteImg!);
    if(response['status']=="success")
    {
      print('add note successfully');
      getAllNotes(userId);
      emit(AddNoteSuccess());
    }else{
      emit(AddNoteError(errMsg: response['status']));

    }
  }

  Future <void>editNote(String userId, String title,String content,String noteId, imageName)async
  {
    emit(EditNoteLoading());
    var response = await _crud.postRequest(editNotesLink, {
      'noteid': noteId,
      'content': content,
      'title': title,
      'imagename':imageName

    });
    if(response['status']=="success")
      {
        print('edit note successfully');
        getAllNotes(userId);
        emit(EditNoteSuccess());
      }else{
      emit(EditNoteError(errMsg: response['status']));
      print(response['status']);
    }

  }
  bool changeImg=false;
  void selectNewNoteImg(){
    changeImg=!changeImg;
    print(changeImg);
    emit(ChangeImg());
  }
  Future <void>editNoteImage(String userId, String title,String content,String noteId,imageName,File? noteImg)async
  {
    emit(EditNoteLoading());
    var response = await _crud.postReqWithFile(editNotesLink, {
      'noteid': noteId,
      'content': content,
      'title': title,
      'imagename':imageName
    },noteImg!);
    if(response['status']=="success")
    {
      print('edit note successfully');
      getAllNotes(userId);
      emit(EditNoteSuccess());
    }else{
      emit(EditNoteError(errMsg: response['status']));
    }

  }
  Future <void>deleteNote(String noteId,String userId,String imgName)async{
    emit(DeleteNoteLoading());
    var response=await _crud.postRequest(deleteNotesLink,{
      'noteid':noteId,
      'imagename':imgName
    });
    if(response['status']=="success")
      {
        getAllNotes(userId);
        emit(DeleteNoteSuccess());
      }
    else{
      emit(DeleteNoteError(errMsg: response['status']));
    }

  }
  File? file;
  Future <void> uploadImage(ImageSource source)async{
    XFile? xfile=await ImagePicker().pickImage(source: source);
    file=File(xfile!.path);


}


  SignOut(BuildContext context)async{
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (route) => false);
    await SharedPref.signOut();


  }
}
/*  Future<void>addNote(String userId,String title,String content)async{
    emit(AddNoteLoading());
    var response=await _crud.postRequest(addNotesLink, {
      'userid':userId,
      'content':content,
      'title':title,

    });
    if(response['status']=="success")
    {
      print('add note successfully');
      getAllNotes(response);
      emit(AddNoteSuccess());
    }else{
      emit(AddNoteError(errMsg: response['status']));

    }
  }*/