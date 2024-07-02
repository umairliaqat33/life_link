import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:life_link/utils/colors.dart';

class NetworkConnectivitController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult[0] == ConnectivityResult.none) {
      Get.dialog(
        barrierDismissible: false,
        const AlertDialog(
          icon: Icon(
            Icons.wifi_off,
            color: redColor,
            size: 20,
          ),
          title: Text(
            "No Internet",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Please connect to internet",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      Get.back();
    }
  }
}
