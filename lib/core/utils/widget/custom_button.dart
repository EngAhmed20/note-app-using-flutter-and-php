import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed, this.textStyle,  this.loading=false});
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final TextStyle?textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 54,
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
            ),
            onPressed: onPressed, child:loading?CircularProgressIndicator():Text(text,style:textStyle?? TextStyle(color: Colors.white),)));
  }
}
