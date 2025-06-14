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
    // Determine the asset path based on the title
    final String iconPath = _getIconPath(socialModel.title);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          socialModel.title == 'Share'
              ? (Share.share(Platform.isAndroid
                  ? socialModel.linkAndroid
                  : socialModel.linkIos))
              : (customlaunchURL(Platform.isAndroid
                  ? socialModel.linkAndroid
                  : socialModel.linkIos));
        },
        child: SvgPicture.asset(
          iconPath,
          height: 35,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  // Helper function to get the icon path
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
        return 'assets/sidebar_icons/radioIcon.svg'; // Fallback icon
    }
  }
}

      // child: Container(
      //   padding: const EdgeInsets.all(10),
      //     child: Row(
      //     children: [
      //       Container(
      //         width: 50,
      //         height: 50,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: socialModel.color ?? Colors.grey, // Circle color
      //         ),
      //         child: Center(
      //           child: SvgPicture.network(
      //             socialModel.iconUrl,
      //             width: 25,
      //             height: 25,
      //             colorFilter: ColorFilter.mode(
      //               Colors.white, // Icon color
      //               BlendMode.srcIn,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // child: Row(
      //   children: [
      //     SvgPicture.network(socialModel.iconUrl , width: 25,height: 25,colorFilter: ColorFilter.mode(socialModel.color??Colors.black, BlendMode.srcIn),),
      //     // const SizedBox(width: 10),
      //     // Text(
      //     //   socialModel.title,
      //     //   style: const TextStyle(
      //     //     fontSize: 20,
      //     //     fontWeight: FontWeight.bold,
      //     //   ),
      //     // ),
      //   ],
      // ),
      // ),
//     );
//   }
// }
