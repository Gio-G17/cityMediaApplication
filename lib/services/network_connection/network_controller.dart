import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voiceofgospel/theme/colors.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity=Connectivity();
  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult){
    if(connectivityResult.contains(ConnectivityResult.none) ){
      Get.rawSnackbar(
        messageText: Text("please_connect_to_the_internet".tr,style: const TextStyle(
      fontSize: 14,
      color: AppColors.textPrimaryColor,
    ),),
      isDismissible: false,
      duration: const Duration(days: 1),
backgroundColor: Colors.red[400]!,
icon: const Icon(Icons.wifi_off, color: AppColors.iconsColorActive, size: 35,),
margin: EdgeInsets. zero,
snackStyle: SnackStyle.GROUNDED
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
    /// you have always to check if there is internet when you open the app because the stream will not handle it
  void firstCheck()async{
    List<ConnectivityResult> conx = await Connectivity().checkConnectivity();
    _updateConnectionStatus(conx);
  }
}