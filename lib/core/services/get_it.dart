import 'package:get_it/get_it.dart';
import 'package:php_note/api/crud.dart';

final getit=GetIt.instance;
class ServicesLoacator{
  void init(){
    getit.registerSingleton<CRUD>(CRUD());
  }
}

