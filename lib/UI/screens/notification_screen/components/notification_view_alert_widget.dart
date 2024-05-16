import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_tile.dart';
import 'package:life_link/utils/colors.dart';

class NotificationViewingAlertWidget extends StatelessWidget {
  const NotificationViewingAlertWidget({
    super.key,
    required this.from,
    required this.notificationDate,
    required this.notificationMessage,
    required this.notificationTitle,
  });
  final String from;
  final String notificationDate;
  final String notificationMessage;
  final String notificationTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: scaffoldColor,
      title: Text(notificationTitle),
      content: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoCardTile(
                title: "From",
                valueText: from,
              ),
              InfoCardTile(
                title: "Message",
                valueText: notificationMessage,
              ),
              InfoCardTile(
                title: "Date",
                valueText: notificationDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
