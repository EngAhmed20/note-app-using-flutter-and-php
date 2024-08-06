import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/core/services/shared_pref.dart';
import 'package:php_note/feature/home/controller/home_cubit.dart';
import 'package:php_note/feature/home/widgets/add_note.dart';
import 'package:php_note/feature/home/widgets/card_note.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var note=cubit.notes;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (context) {
                      return addNoteScr();
                    });
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            appBar: AppBar(
              title: Text('Home'),
              actions: [
                IconButton(
                    onPressed: () async {
                      await cubit.SignOut(context);
                    },
                    icon: Icon(Icons.logout, color: Colors.red)),
              ],
              centerTitle: true,
            ),
            body: note !=null?Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: note['data'].length,
                itemBuilder: (context, index) {
                  return NoteCard(data: cubit.noteModel!.data![index],
                  onTap: ()async{
                    await cubit.deleteNote(note['data'][index]['notes_id'].toString(),SharedPref.getString(userId),note['data'][index]['notes_image']);
                  },
                  );
                },

            )
          ):Center(child: Text('There is no notes untill  now',style: TextStyle(fontSize: 20),)),
          );
        },
        listener: (context, state) {

        });
  }
}
