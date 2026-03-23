import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cityMedia/features/domain/social_model.dart';
import 'package:cityMedia/theme/colors.dart';
import 'package:cityMedia/utilities/function.dart';

class SocialWidgetButton extends StatelessWidget {
  const SocialWidgetButton({
    super.key,
    required this.socialModel,
  });

  final SocialModel socialModel;

 @override
Widget build(BuildContext context) {
  if (socialModel.title == 'YouTube' || socialModel.title == 'Website') {
    return const SizedBox.shrink();
  }

  final String iconPath = _getIconPath(socialModel.title);

  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: InkWell(
      onTap: () {
        if (socialModel.title == 'Share') {
          Share.share(
            Platform.isAndroid
                ? socialModel.linkAndroid
                : socialModel.linkIos,
          );
        } else {
          customlaunchURL(
            Platform.isAndroid
                ? socialModel.linkAndroid
                : socialModel.linkIos,
          );
        }
      },
      child: SvgPicture.asset(
        iconPath,
        height: 35,
        color: AppColors.primaryColor,
      ),
    ),
  );
}

  String _getIconPath(String title) {
    switch (title.toLowerCase()) {
      case 'facebook':
        return 'assets/sidebar_icons/facebookIcon.svg';
      case 'website':
        return 'assets/sidebar_icons/websiteIcon.svg';
      case 'youtube':
        return 'assets/sidebar_icons/youtubeIcon.svg';
      case 'whatsapp':
        return 'assets/sidebar_icons/whatsappIcon.svg';
      case 'instagram':
        return 'assets/sidebar_icons/instagramIcon.svg';
      case 'share':
        return 'assets/sidebar_icons/sahreIcon.svg';
      default:
        return 'assets/sidebar_icons/radioIcon.svg';
    }
  }
}
