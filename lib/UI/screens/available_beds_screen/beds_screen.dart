import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/available_beds_screen/components/bed_add.dart';
import 'package:life_link/UI/screens/available_beds_screen/components/avail_bed_card.dart';
import 'package:life_link/UI/screens/available_beds_screen/components/unavial_bed_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class BedsScreen extends StatefulWidget {
  const BedsScreen({super.key});

  @override
  State<BedsScreen> createState() => _BedsScreenState();
}

class _BedsScreenState extends State<BedsScreen> {
  late bool _toggleValue = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBarWidget(
            title: "Bed Management",
            context: context,
            backButton: true,
          ),
          floatingActionButton: _toggleValue
              ? FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () => addBed(context),
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                )
              : null,
          body: Stack(
            children: [
              Container(
                  color: appBarColor,
                  width: SizeConfig.width(context),
                  height: SizeConfig.height(context) / 6,
                  child: null),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.height(context) / 20),
                  child: Column(
                    children: [
                      Text(
                        _toggleValue ? "10" : "5",
                        style: TextStyle(
                            fontSize: SizeConfig.font28(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Text(
                        "Total Records",
                        style: TextStyle(
                            fontSize: SizeConfig.font14(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      SizedBox(
                        height: SizeConfig.height20(context) * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: greyColor)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        _toggleValue
                                            ? greenColor
                                            : Colors.transparent),
                              ),
                              onPressed: () => changedAvailableButton(),
                              child: Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: SizeConfig.font16(context),
                                  color: _toggleValue ? whiteColor : greyColor,
                                ),
                              )),
                          TextButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: greyColor)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .zero, // Set border radius to zero for square shape
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        _toggleValue
                                            ? Colors.transparent
                                            : redColor),
                              ),
                              onPressed: () => changeUnavailableButton(),
                              child: Text(
                                "UnAvailable",
                                style: TextStyle(
                                    fontSize: SizeConfig.font16(context),
                                    color:
                                        _toggleValue ? greyColor : whiteColor),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height(context) / 4,
                ),
                child: SingleChildScrollView(
                  child: _toggleValue
                      ? const Column(
                          children: [
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                            AvailBedCard(),
                          ],
                        )
                      : const Column(
                          children: [
                            UnAvailBedCard(),
                            UnAvailBedCard(),
                            UnAvailBedCard(),
                            UnAvailBedCard(),
                            UnAvailBedCard(),
                          ],
                        ),
                ),
              ),
            ],
          )),
    );
  }

  void changedAvailableButton() {
    setState(() {
      _toggleValue = true;
    });
  }

  void changeUnavailableButton() {
    setState(() {
      _toggleValue = false;
    });
  }

  void addBed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddingBed();
        });
  }
}
