
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future displayBottomSheet(
    BuildContext context, http.Response response, String reason) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black38,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SvgPicture.asset('assets/images/miban4_colored_logo.svg', width: 180,),
                const SizedBox(height: 16,),
                Text(
                  "${AppLocalizations.of(context)!.dialogErro}: ${response.statusCode}",
                  style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(reason)
              ],
            ),
          ),
        );
      });
}
