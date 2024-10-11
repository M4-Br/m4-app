import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<Future> responseAlert(BuildContext context, String error, String reason) async {
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        children: [
          SvgPicture.asset('assets/images/miban4_colored_logo.svg', width: 180,),
          Text("Erro: $error"),
          Text(reason),
        ],
      ),
    );
  });
}