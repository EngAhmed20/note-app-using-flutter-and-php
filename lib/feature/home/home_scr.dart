import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/core/services/shared_pref.dart';
import 'package:php_note/feature/auth/login.dart';
import 'package:php_note/feature/home/controller/home_cubit.dart';
import 'package:php_note/feature/home/widgets/add_note.dart';
import 'package:php_note/feature/home/widgets/card_note.dart';
import 'package:php_note/feature/home/widgets/home_body.dart';

import '../../api/crud.dart';
import '../../constant.dart';
import '../../core/services/get_it.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}

