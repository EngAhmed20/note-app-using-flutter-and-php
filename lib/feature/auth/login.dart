import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/feature/auth/widget/login_body.dart';
import '../../api/crud.dart';
import '../../core/services/get_it.dart';
import 'controller/auth_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthCubit(getit<CRUD>()),
      child: loginScr(),
    );
  }
}
