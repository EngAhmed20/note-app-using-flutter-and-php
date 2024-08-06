import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class noteBlocObserver implements BlocObserver{
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    if (kDebugMode) {
      log('change=$change');

    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (kDebugMode) {
      log('onClose=$bloc');
    }

  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    if (kDebugMode) {
      log('onCreate=$bloc');
    }

  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition
      ) {
  }

}