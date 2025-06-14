import 'package:flutter/material.dart';
import 'package:voiceofgospel/utilities/function.dart';

class StationModel{
  final String urlAudio;
  final String urlHomeBackGround;
  final String urlMidleLogo;
  final String urlHeaderLogo;
  final Color urlColorMidleLogo;
  final String name;
  final String playing;
  final String slug;
  final String about;
  final String description;
  final String linkPrivacyPolicy;

  StationModel({required this.urlHomeBackGround,required this.urlMidleLogo,required this.urlHeaderLogo,required this.urlColorMidleLogo,required this.name,
  required this.playing,
  required this.linkPrivacyPolicy,
  required this.about,
  required this.description,
  required this.slug,required this.urlAudio});
  factory StationModel.fromMap(Map<String,dynamic> map){
    return StationModel(
      name: map['name'],playing: map['playing'],
      slug: map['slug'],
      about: map['about'],
      description: map['description'],
      urlAudio: map['urlAudio']  ,
      urlMidleLogo: map['home_logo_middle'],
      urlHeaderLogo: map['home_logo_header'],
      urlColorMidleLogo: hexToColor(map['home_logo_color_container']),
          urlHomeBackGround: map["home_background"],
          linkPrivacyPolicy: map["link_privacy_policy"],

    );
  }
}