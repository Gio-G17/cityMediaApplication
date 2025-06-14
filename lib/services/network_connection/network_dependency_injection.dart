import 'package:get/get.dart';
import 'package:cityMedia/services/network_connection/network_controller.dart';

class NetworkDependencyInjection{
  static void init(){
 Get.put<NetworkController>(NetworkController(),permanent: true);
     Get.find<NetworkController>().firstCheck();
  }
}