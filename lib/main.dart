import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:voiceofgospel/features/data/data_repository.dart';
import 'package:voiceofgospel/features/screens/splash/spalsh_screen.dart';
import 'package:voiceofgospel/services/firebase_services.dart';
import 'package:voiceofgospel/services/local_notification_service.dart';
import 'package:voiceofgospel/services/network_connection/network_dependency_injection.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/screens/home/home_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
}
late PackageInfo packageInfo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  packageInfo = await PackageInfo.fromPlatform();
  runApp(const ProviderScope(child: MyApp()));
  NetworkDependencyInjection.init();
  await FirebaseServices().init();
  await NotificationService().init();
  FirebaseMessaging.instance.subscribeToTopic("all");
}

class MyApp extends StatefulWidget {

const MyApp ({super.key});

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  void initState(){
    super.initState();
    intialization();
  }

  void intialization() async {
print('pausing.......');
await Future.delayed(const Duration(seconds: 3));
print('unpausing.......');
FlutterNativeSplash.remove();

  }

  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'voice of gospel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      // home: const MyHomePage(title: 'VOG'),
      home: UpgradeAlert(
          showLater: false,
          showIgnore: false,
          upgrader: Upgrader(
            durationUntilAlertAgain: Duration.zero,
          ),
          barrierDismissible: false,
          // child: const HomeScreen()),
      child: const SpalshScreen(),),
      // home: Scaffold(body: Center(child: Consumer(
      //   builder: (context,ref,_) {
      //     return ElevatedButton(onPressed: () async{
      //     //  await ref.read(getSocialProv.future);
      //      await ref.read(getShareProv.future);
      //     },
      //     child: Text("GetData"),
      //     );
      //   }
      // ),),),
    );
  }
}

 
/* https://docs.flutter.dev/deployment/android#enabling-multidex-support */