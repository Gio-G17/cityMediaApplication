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
  // Trim whitespace and convert to uppercase
  hexString = hexString.trim().toUpperCase().replaceAll("#", "");

  // Check if the string is of a valid length and only contains hexadecimal characters
  if (hexString.length != 6 && hexString.length != 8 || !RegExp(r'^[0-9A-F]+$').hasMatch(hexString)) {
    return defaultColor; // Return default color if input is invalid
  }

  // Ensure full opacity if no alpha value is provided
  if (hexString.length == 6) {
    hexString = "FF" + hexString;
  }

  try {
    // Try parsing the hex string into a Color
    return Color(int.parse("0x$hexString"));
  } catch (e) {
    // If an error occurs during parsing, return the default color
    return defaultColor;
  }
}

