import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Colors.amber;
var CURRENTUSERID;
Widget buildCustomText(
    {required String text,
    double size = 18,
    int max = 1,
    FontWeight fontWeight = FontWeight.bold,
    Color color = Colors.black}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: max,
    style: GoogleFonts.nunito(
        fontSize: size, fontWeight: fontWeight, color: color),
  );
}

Widget buildCustomTextFormField(
    {required String hintText,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
    bool obsc = false,
    var widget}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obsc,
      style: GoogleFonts.nunito(fontSize: 20),
      decoration: InputDecoration(
          labelText: hintText,
          labelStyle: GoogleFonts.nunito(fontSize: 20),
          suffixIcon: widget,
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    ),
  );
}

Widget buildNextButton({required Function() onTap}) {
  return Container(
    width: 60,
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(20)),
    child: IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: onTap,
    ),
  );
}
