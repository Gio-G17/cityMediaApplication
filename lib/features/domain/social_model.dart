import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../utilities/function.dart';

class SocialModel {
  final String linkAndroid;
  final String linkIos;
  final String title;
  final String iconUrl;
  final Color? color;
  final int iconOrder;

  SocialModel(
      {required this.linkAndroid,
      required this.linkIos,
      required this.title,
      required this.iconUrl,
      required this.iconOrder,

      this.color});
  factory SocialModel.fromMap(Map<String, dynamic> map) {
    print(colorMap[map['iconColor']]);
    return SocialModel(
      linkAndroid: map["link_android"],
      linkIos: map['link_ios'],
      title: map['iconTitle'],
      iconUrl: map['iconUrl'],
      color: hexToColor(map['iconColor']),
      iconOrder: map['iconOrder'],
    );
  }
}

Map<String, Color> colorMap = {
  'red': Colors.red,
  'blue': Colors.blue,
  'green': Colors.green,
  // Add more colors as needed
};
