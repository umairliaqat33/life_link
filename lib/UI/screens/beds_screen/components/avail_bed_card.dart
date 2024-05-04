import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class AvailBedCard extends StatelessWidget {
  const AvailBedCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.width10(context),
          left: SizeConfig.width10(context),
          bottom: 2),
      child: Card(
        child: ListTile(
          title: Text(
            "BD-0001",
            style: TextStyle(fontSize: SizeConfig.font18(context)),
          ),
          leading: const Icon(Icons.bed_rounded),
          subtitle: const Text("Not Assigned"),
          trailing: IconButton(
            color: redColor,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _beddelete(context),
          ),
        ),
      ),
    );
  }

  void _beddelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            title: const Text("Are you Sure you want to Delete!"),
            actions: [
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {},
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
