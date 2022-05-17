import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton( {
    Key? key, this.title, this.onPressed, this.padding,
  }) : super(key: key);

  final String? title;
  final onPressed,padding;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(onPressed: onPressed,
      child: Text(title!),
      style: ElevatedButton.styleFrom(
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
      ),);
  }
}