
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
    fontSize: fontSize,
    fontWeight: fontWeight
  );
}

TextStyle sharpLightFont({double? fontSize, FontWeight? fontWeight,Color? color}){
  return GoogleFonts.workSans(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight
  );
}