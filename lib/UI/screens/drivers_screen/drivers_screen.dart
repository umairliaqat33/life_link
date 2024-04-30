import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Manage Drivers",
        context: context,
        backButton: true,
      ),
    );
  }
}
