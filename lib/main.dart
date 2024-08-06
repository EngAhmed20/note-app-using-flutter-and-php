import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/core/services/get_it.dart';
import 'package:php_note/core/services/shared_pref.dart';
import 'package:php_note/feature/auth/login.dart';
import 'package:php_note/feature/home/controller/home_cubit.dart';
import 'package:php_note/feature/home/widgets/edit_notes.dart';
import 'api/crud.dart';
import 'bloc_observer.dart';
import 'feature/auth/sign_up.dart';
import 'feature/home/home_scr.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLoacator().init();
  Bloc.observer= noteBlocObserver();
  await SharedPref.init();
 String id= SharedPref.getString(userId);
  runApp( MyApp(user: id,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.user});
  String user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit(getit<CRUD>())..getAllNotes(SharedPref.getString(userId))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) =>user ==''? LoginView():HomeScr(),
          "register": (context) => SignUp(),
          "home": (context) => HomeScr (),


        },
      ),
    );
  }
}


