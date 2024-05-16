import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/notification_screen/components/notification_tile.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/notification_model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final FirestoreController _firestoreController = FirestoreController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: 'Notifications',
        context: context,
        backButton: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.width15(context) + 1,
          right: SizeConfig.width15(context) + 1,
        ),
        child: StreamBuilder<List<NotificationModel>>(
            stream: _firestoreController.getNotificationModelStreamList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularLoaderWidget();
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    "Something went wrong please try again",
                    style: TextStyle(
                      fontSize: SizeConfig.font20(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              if (snapshot.data != null && snapshot.data!.isEmpty) {
                return const Center(
                  child: NoDataWidget(alertText: "No notifications yet"),
                );
              }
              List<NotificationModel> notificationModelList = snapshot.data!;
              return Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: const Icon(Icons.search),
                  //       hintText: 'Search Notification',
                  //       contentPadding: const EdgeInsets.all(16.0),
                  //       fillColor: Colors.black12,
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //         borderRadius: BorderRadius.circular(20.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NotificationTile(
                          notificationModel: notificationModelList[index],
                        );
                      },
                      itemCount: notificationModelList.length,
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
