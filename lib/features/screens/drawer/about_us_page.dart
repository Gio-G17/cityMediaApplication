import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cityMedia/features/data/data_repository.dart';
import 'package:cityMedia/features/widgets/sidebar_widgets/sidebar_footer.dart';
import 'package:cityMedia/features/widgets/sidebar_widgets/sidebar_header.dart';
import 'package:cityMedia/main.dart';
import 'package:cityMedia/theme/colors.dart';
import 'package:cityMedia/utilities/function.dart';

class AboutUsPage extends StatelessWidget {
  final VoidCallback onBack;

  const AboutUsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey(1),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        children: [
          SidebarHeader(
            onBack: onBack,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer(builder: (context, ref, _) {
                    return Text(
                      ref.read(getStationProv).value!.name,
                      style: const TextStyle(
                          color: AppColors.textPrimaryColor,
                          fontSize: 37,
                          fontWeight: FontWeight.bold),
                    );
                  }),

                  Consumer(builder: (context, ref, _) {
                    return Text(
                      ref.read(getStationProv).value!.about,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textSecondaryColor,
                        height: 3,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                  // const Text(
                  //   "\nWELCOME TO VOG\n\nYOUR GATEWAY TO ARAB CULTURE IN QATAR"
                  //   "Welcome to Habaieb FM, Qatar's inaugural radio station! Broadcasting from (address, Doha, Qatar), "
                  //   "we’re your go-to destination for diverse music and entertainment."
                  //   "Join us in redefining radio with a mix of tradition and innovation. "
                  //   "Tune in and be part of history at Habaieb FM!\n",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.normal,
                  //     color: Color.fromARGB(255, 153, 153, 153),
                  //     height: 3,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),

                  Consumer(
                    builder: (context, ref, _) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          child: Text.rich(
                            TextSpan(
                              text: 'Privacy Policy', // Main text
                              style: const TextStyle(
                                fontWeight: FontWeight
                                    .bold, // Bold style for Privacy Policy
                                fontSize: 16,
                                color: AppColors.textSecondaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' App version  ${packageInfo.version}', // Subscript text
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.normal, // Normal weight
                                    fontSize: 8,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            final privacyPolicyLink =
                                ref.read(getStationProv).value?.linkPrivacyPolicy;
                            if (privacyPolicyLink != null) {
                              customlaunchURL(privacyPolicyLink);
                            } else {
                              // Handle null URL case if needed
                              debugPrint('Privacy policy link is not available.');
                            }
                          },
                        ),
                      );
                    },
                  ),

                  // final url =
                  //     Uri.parse('https://lit-online.com');
                  // if (await canLaunchUrl(url)) {
                  //   launchUrl(url);
                  // } else {
                  //   // Handle error, e.g., show a dialog
                  // }
                ],
              ),
            ),
          ),
          const SidebarFooter(),
        ],
      ),
    );
  }
}
