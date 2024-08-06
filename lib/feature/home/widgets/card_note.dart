import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:php_note/constant.dart';
import 'package:php_note/feature/home/widgets/edit_notes.dart';

import '../../model/note_model.dart';

class NoteCard extends StatelessWidget {
   NoteCard({
    super.key, required this.data,required this.onTap
  });
  final Data data;
   void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: ()async{
            await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditNote(content: data.notesContent!,
                title:data.notesTitle!, noteId: data.notesId.toString(),img: data.notesImage!,)
            ));
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    child: Image.network('$imgRoot/${data.notesImage}',height: 100,width: 100,fit: BoxFit.fill,)),
                Flexible(
                  flex: 2,
                  child: ListTile(title:Text(data.notesTitle!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Text(data.notesContent!,style: TextStyle(fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(right: 1,bottom: 1,top: 1,
            child: IconButton(onPressed: onTap, icon: Icon(Icons.delete,size: 35,color: Colors.red)))
      ],
    );
  }
}
