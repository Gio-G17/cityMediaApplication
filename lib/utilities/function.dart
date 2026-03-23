import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cityMedia/theme/colors.dart';
customlaunchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    print('Could not launch $url');
  }
}


Color hexToColor(String hexString, {Color defaultColor =  AppColors.textPrimaryColor}) {
  hexString = hexString.trim().toUpperCase().replaceAll("#", "");

  if (hexString.length != 6 && hexString.length != 8 || !RegExp(r'^[0-9A-F]+$').hasMatch(hexString)) {
    return defaultColor;
  }

  if (hexString.length == 6) {
    hexString = "FF" + hexString;
  }

  try {
    return Color(int.parse("0x$hexString"));
  } catch (e) {
    return defaultColor;
  }
}

