import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/available_beds_screen/components/bed_add.dart';
import 'package:life_link/UI/screens/available_beds_screen/components/bedcard.dart';
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
    return Scaffold(
        appBar: appBarWidget(
          title: "History",
          context: context,
          backButton: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AddingBed();
            //   },
            // );
          },
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Stack(
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
                        "10",
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
              Positioned(
                top: SizeConfig.height(context) / 4, // Adjust as needed
                width: SizeConfig.width(context),
                child: _toggleValue
                    ? Column(
                        children: [
                          BedCard(),
                          BedCard(),
                          BedCard(),
                          BedCard(),
                          BedCard(),
                        ],
                      )
                    : const SizedBox(), // Conditionally show BedCard
              ),
            ],
          ),
        ));
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
}
