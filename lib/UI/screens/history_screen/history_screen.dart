import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile(
          title: Text(
            "Patient Name",
          ),
          subtitle: Text("data"),
        );
      },
    ));
  }
}
