import 'package:get/get.dart';
import 'package:life_link/controllers/network_connectivity_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkConnectivitController>(
      NetworkConnectivitController(),
      permanent: true,
    );
  }
}
