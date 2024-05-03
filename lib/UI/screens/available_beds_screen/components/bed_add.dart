import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class AddingBed extends StatefulWidget {
  const AddingBed({super.key});

  @override
  State<AddingBed> createState() => _AddingBedState();
}

class _AddingBedState extends State<AddingBed> {
  int numberOfBeds = 1; // Initial number of beds

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: scaffoldColor,
      title: Row(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add Beds"),
                  IconButton(
                    color: redColor,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.height15(context),
              ),
              Card(
                child: ListTile(
                  title: const Text("No of Beds: "),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (numberOfBeds > 1) {
                            setState(() {
                              numberOfBeds--;
                            });
                          }
                        },
                      ),
                      Text(
                        "$numberOfBeds",
                        style: TextStyle(fontSize: SizeConfig.font14(context)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            numberOfBeds++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            // Save functionality goes here
          },
          child: const Text(
            "SAVE",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
