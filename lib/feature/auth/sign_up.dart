import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/core/services/get_it.dart';
import 'package:php_note/feature/auth/controller/auth_cubit.dart';
import 'package:php_note/feature/auth/widget/sign_up.dart';

import '../../api/crud.dart';
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthCubit(getit<CRUD>()),
    child: SignupScr(),
    );
  }
}
