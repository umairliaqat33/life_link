import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/notification_screen/components/notification_view_alert_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/notification_model/notification_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({
    super.key,
    required this.notificationModel,
  });
  final NotificationModel notificationModel;

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  UserModel? _userModel;
  final FirestoreController _firestoreController = FirestoreController();

  @override
  void initState() {
    super.initState();
    _getRequiredModels();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNotificationDataViewingAlert(),
      child: Card(
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => _deleteNotification(),
                icon: Icons.delete,
                foregroundColor: Colors.white,
                backgroundColor: Colors.red[800]!,
              )
            ],
          ),
          child: ListTile(
            isThreeLine: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: SizeConfig.width10(context)),
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/app_logo.png'),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _userModel?.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.notificationModel.title,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            subtitle: Text(
              widget.notificationModel.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getRequiredModels() async {
    if (widget.notificationModel.fromId ==
        FirestoreRepository.checkUser()!.uid) {
      _userModel = await _firestoreController
          .getSpecificUserModel(widget.notificationModel.toId);
    } else {
      _userModel = await _firestoreController
          .getSpecificUserModel(widget.notificationModel.fromId);
    }

    setState(() {});
  }

  void _showNotificationDataViewingAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationViewingAlertWidget(
          from: _userModel?.name ?? "",
          notificationDate: widget.notificationModel.notificationTime,
          notificationMessage: widget.notificationModel.message,
          notificationTitle: widget.notificationModel.title,
        );
      },
    );
  }

  void _deleteNotification() {
    try {
      _firestoreController
          .deleteNotification(widget.notificationModel.notificationId);
      Fluttertoast.showToast(msg: "Notification Deleted");
    } catch (e) {
      log("Error at deleting notification in notification tile: ${e.toString()}");
    }
  }
}
