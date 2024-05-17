import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class AddingBed extends StatefulWidget {
  const AddingBed({
    super.key,
    required this.hopspitalId,
    required this.totalBeds,
  });
  final String hopspitalId;
  final int totalBeds;
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
          Expanded(
            flex: 3,
            child: Column(
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
                          style:
                              TextStyle(fontSize: SizeConfig.font14(context)),
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
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () => _addBedsButton(numberOfBeds),
          child: const Text(
            "ADD",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _addBedsButton(int beds) {
    try {
      FirestoreController firestoreController = FirestoreController();

      for (int i = 0; i < beds + widget.totalBeds; i++) {
        firestoreController.addBed(
          BedModel(
            bedId: int.parse("${widget.totalBeds + i + 1}"),
            hospitalId: widget.hopspitalId,
          ),
        );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
        (route) => false,
      );
      Fluttertoast.showToast(
        msg: "Beds added",
      );
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on FormatParsingException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on UnknownException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    }
  }
}
