import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cityMedia/theme/images.dart';
import 'package:cityMedia/theme/strings.dart';
import 'package:cityMedia/features/data/data_repository.dart';
import 'package:cityMedia/features/widgets/about_sized_box.dart';
import 'package:cityMedia/features/widgets/body_text.dart';
import 'package:cityMedia/main.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           
              const AboutSizedBox(),
              Consumer(
                builder: (context,ref,_) {
                  return Text(
                    ref.read(getStationProv).value!.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }
              ),
              const AboutSizedBox(),
              Text(
                "Version ${packageInfo.version}",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context,ref,_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  BodyText(text: ref.read(getStationProv).value!.description),
                  const AboutSizedBox(),
                  BodyText(text: ref.read(getStationProv).value!.about),
                  const AboutSizedBox(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
