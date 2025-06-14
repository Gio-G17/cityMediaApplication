import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cityMedia/features/data/data_repository.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cityMedia/features/widgets/sidebar_widgets/sidebar_footer.dart';
import 'package:cityMedia/features/widgets/sidebar_widgets/sidebar_header.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cityMedia/theme/colors.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactPage extends ConsumerStatefulWidget {
  final VoidCallback onBack;

  const ContactPage({super.key, required this.onBack});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();

  // v2Server = ref.read(getServerProv).value!.,

  getServerData() async {
    print('I am in ASYNNNCCCCCCCC');
    await Future.wait([
      ref.read(getServerProv.future),
    ]);
    if (mounted) {
      setState(() {
        print('I am in set stateeeeeeeeeeeeeeeee');
      });
    }
  }

  // @override
  // void initState() {
  //   getServerData();

  //   print('I am in set REAAADDDDYYYYYYYY');

  //   super.initState();
  // }

  late final KeyboardVisibilityController _keyboardVisibilityController;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    getServerData();

    _keyboardVisibilityController = KeyboardVisibilityController();
    _isKeyboardVisible = _keyboardVisibilityController.isVisible;

    // Listen to keyboard visibility changes
    _keyboardVisibilityController.onChange.listen((bool isVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void sendEmail({
    required String nameText,
    required String emailText,
    required String phoneText,
    required String noteText,
  }) async {
    final smtpServer = gmail('${ref.read(getServerProv).value?.smtpEmail}',
        '${ref.read(getServerProv).value?.smtpPass}'); // Replace with your email and app password

print('EEEMAAAILLLL: ${ref.read(getServerProv).value?.smtpEmail}');
print('PASSSSSSSSS:  ${ref.read(getServerProv).value?.smtpPass}');

    final message = Message()
      ..from = Address(emailText, 'Contact Form')
      ..recipients.add(
          'giorgioghantous@gmail.com') // Replace with the recipient's email
      ..subject = 'Contact Form Submission :: ${DateTime.now()}'
      ..text = 'Name: ${nameText}\n'
          'Email: ${emailText}\n'
          'Phone Number: ${phoneText}\n'
          'Note: ${noteText}';

    try {
      final sendReport = await send(message, smtpServer);
      print('worked');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Message sent: ${sendReport.toString()}')),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message: $e'),
          backgroundColor: AppColors.backgroundColor,
        ),
      );
    }
  }

  // @override
  Widget build(BuildContext context) {
// print(_isKeyboardOpen);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        children: [
          SidebarHeader(onBack: widget.onBack),
          const Text(
            'Contact Us',
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 37,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      controller: nameController,
                      hintText: 'Name',
                      borderRadius: 10,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      controller: emailController,
                      hintText: 'Email',
                      borderRadius: 10,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      controller: phoneController,
                      hintText: 'Phone Number',
                      borderRadius: 10,
                    ),
                  ),
                  Expanded(
                    flex: _isKeyboardVisible ? 1 : 4,
                    child: _buildTextField(
                      controller: noteController,
                      hintText: 'Note',
                      borderRadius: 10,
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        sendEmail(
                            nameText: nameController.text.toString(),
                            emailText: emailController.text.toString(),
                            phoneText: phoneController.text.toString(),
                            noteText: noteController.text.toString());

                        Navigator.of(context).pop(); // Closes the drawer

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Message sent successfully!'),
                            backgroundColor: AppColors.backgroundColor,
                          ),
                        );

                        // Clear the input fields
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        noteController.clear();

                        // Show confirmation message

                        // Navigate back to the home page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textTertiaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // _isKeyboardVisible
          //     ? SizedBox.shrink()
          //     : Padding(
          //         padding: EdgeInsets.all(15.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Consumer(builder: (context, ref, _) {
          //               final phoneNb =
          //                   ref.watch(getContactsProv).value?.phoneNb ?? 'N/A';
          //               return Text(
          //                 phoneNb,
          //                 style: const TextStyle(
          //                     color: AppColors.textSecondaryColor,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.normal),
          //               );
          //             }),
          //             Consumer(builder: (context, ref, _) {
          //               final email =
          //                   ref.watch(getContactsProv).value?.email ?? 'N/A';
          //               return Text(
          //                 email,
          //                 style: const TextStyle(
          //                     color: AppColors.textSecondaryColor,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.normal),
          //               );
          //             }),
          //           ],
          //         ),
          //       ),
          _isKeyboardVisible ? SizedBox.shrink() : const SidebarFooter(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required double borderRadius,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    int? maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textSecondaryColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
