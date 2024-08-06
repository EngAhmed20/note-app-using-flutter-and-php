import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextForm(
    {required TextEditingController controller,
      TextInputType? type,
      Function(String)? onSubmit,
      Function(String)? onChange,
      VoidCallback? ontap,
      required String? Function(String?)? validator,
      TextAlign align=TextAlign.start,
      String? hint,
      int maxLines = 1,
      TextStyle? textStyle,
      InputBorder? border,
      Widget? leadingIcon,
      Widget? trailingIcon,
      IconData? preficon,
      VoidCallback? sufixpress,
      bool ispass = false,
      IconData? suficon,
      void Function(String?)? onSaved,
      bool isCleckable = true,
      bool read_only = false}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      enabled: isCleckable,
      style: textStyle,
      obscureText: ispass,
      onChanged: onChange,
      onSaved: onSaved,
      readOnly: read_only,
      onTap: ontap,
      textAlign:align ,
      cursorColor: Colors.blue,
     // style: textStyle.semiBold16.copyWith(color: Colors.black),
      onFieldSubmitted: onSubmit,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffdde5e5),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),

        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        border:_inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        prefixIcon: Icon(preficon),
        suffixIcon: IconButton(onPressed: sufixpress, icon: Icon(suficon)),
      ),
      validator: validator,
    );

OutlineInputBorder _inputBorder(){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
          color: Color(0xffb7c0c0),
        width: 1.0,
      )
  );
}