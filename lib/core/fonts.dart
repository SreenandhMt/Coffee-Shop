
import 'package:coffee_app/core/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle subtitleFont({double? fontSize, FontWeight? fontWeight,Color? color}){
  return GoogleFonts.raleway(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight
  );
}

TextStyle titleFonts({double? fontSize, FontWeight? fontWeight,Color? color}){
  return GoogleFonts.raleway(
    color: color,
    fontSize: fontSize??20,
    fontWeight: fontWeight??FontWeight.w800
  );
}

TextStyle sharpLightFont({double? fontSize, FontWeight? fontWeight,Color? color}){
  return GoogleFonts.workSans(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight
  );
}


final TextStyle appBarTitleFont = titleFonts(fontSize: 20, fontWeight: FontWeight.w700);