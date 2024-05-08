import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/beds_screen/components/bed_add.dart';
import 'package:life_link/UI/screens/beds_screen/components/bed_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class BedsScreen extends StatefulWidget {
  const BedsScreen({
    super.key,
    required this.bedsList,
  });
  final List<bool> bedsList;

  @override
  State<BedsScreen> createState() => _BedsScreenState();
}

class _BedsScreenState extends State<BedsScreen> {
  bool _toggleValue = true;
  final List<bool> _availableBeds = [];
  final List<bool> _unavailableBeds = [];

  @override
  void initState() {
    super.initState();
    _separateBeds();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int j = 0;
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
                onPressed: () => addBed(
                  context,
                  widget.bedsList,
                ),
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
                padding: EdgeInsets.only(top: SizeConfig.height(context) / 20),
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
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _toggleValue
                                      ? greenColor
                                      : Colors.transparent),
                            ),
                            onPressed: () => _onAvailabilityChangeButton(),
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
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .zero, // Set border radius to zero for square shape
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _toggleValue ? Colors.transparent : redColor),
                          ),
                          onPressed: () => _onAvailabilityChangeButton(),
                          child: Text(
                            "UnAvailable",
                            style: TextStyle(
                                fontSize: SizeConfig.font16(context),
                                color: _toggleValue ? greyColor : whiteColor),
                          ),
                        ),
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
              child: ListView.builder(
                itemCount: _toggleValue
                    ? _availableBeds.length
                    : _unavailableBeds.length,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.bedsList.isEmpty) {
                    return const NoDataWidget(
                        alertText: "Please add some beds.");
                  }
                  return BedCard(
                    index: _toggleValue ? i++ : j++,
                    isAvailable: _toggleValue
                        ? _availableBeds[index]
                        : _unavailableBeds[index],
                    mainList: widget.bedsList,
                    mainIndex: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAvailabilityChangeButton() {
    setState(() {
      _toggleValue = !_toggleValue;
    });
  }

  void addBed(
    BuildContext context,
    List<bool> bedlist,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddingBed(
            bedList: bedlist,
          );
        });
  }

  void _separateBeds() {
    for (int i = 0; i < widget.bedsList.length; i++) {
      if (widget.bedsList[i]) {
        _unavailableBeds.add(widget.bedsList[i]);
      } else {
        _availableBeds.add(widget.bedsList[i]);
      }
    }
  }
}
