import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_link/UI/screens/history_screen/component/history_view_alert.dart';
import 'package:life_link/config/size_config.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.width10(context),
          left: SizeConfig.width10(context),
          bottom: 2),
      child: Card(
        child: ListTile(
          title: const Text(
            "Patient Name",
          ),
          leading: IconButton(
            onPressed: () => viewhistorydetail(context),
            icon: const Icon(Icons.visibility),
          ),
          subtitle: const Text("Disease"),
          trailing: Text(DateFormat.yMMMMd().format(DateTime.now())),
        ),
      ),
    );
  }
}

void viewhistorydetail(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const HistoryViewingAlert();
    },
  );
}
