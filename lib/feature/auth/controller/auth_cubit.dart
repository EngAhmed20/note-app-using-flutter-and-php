import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../api/crud.dart';
import '../../../constant.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._crud) : super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);
  final  CRUD _crud;
  signUp({required String name,required String email,required String pass})async{
    emit(AuthLoading());
    var response=await _crud.postRequest(linkAuth, {
      'username':name,
      'email':email,
      'password':pass,
    });
    if(response['status']=="success"){
      emit(AuthSuccess(response));
    }else{
      emit(AuthFailure(response['status']));

    }
  }
  login({required String email,required String password})async{
    emit(AuthLoading());
   var response=await _crud.postRequest(linkLogin,{
      'email':email,
      'password':password,


   });
    if(response['status']=="success"){
      emit(AuthSuccess(response));
    }else{
      emit(AuthFailure(response['status']));

    }

  }
}
