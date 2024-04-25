import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBarWidget(
            title: "History",
            context: context,
            backButton: true,
          ),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: const Text(
                    "Patient Name",
                  ),
                  subtitle: const Text("Disease"),
                  trailing: Text(DateFormat.yMMMMd().format(DateTime.now())),
                ),
              );
            },
          )),
    );
  }
}
