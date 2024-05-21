import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/beds_screen/components/bed_add.dart';
import 'package:life_link/UI/screens/beds_screen/components/bed_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/utils/colors.dart';

class BedsScreen extends StatefulWidget {
  const BedsScreen({
    super.key,
    required this.hospitalId,
  });
  final String hospitalId;

  @override
  State<BedsScreen> createState() => _BedsScreenState();
}

class _BedsScreenState extends State<BedsScreen> {
  final FirestoreController _firestoreController = FirestoreController();
  bool _toggleValue = true;
  final List<BedModel> _availableBeds = [];
  final List<BedModel> _unavailableBeds = [];
  int totalBeds = 0;

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
                onPressed: () => addBed(
                  context,
                  totalBeds,
                ),
                child: const Icon(
                  Icons.add,
                  color: whiteColor,
                ),
              )
            : null,
        body: StreamBuilder<List<BedModel>>(
            stream: _firestoreController.getBedsStreamList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularLoaderWidget();
              }
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                  child: NoDataWidget(alertText: "Please add some beds."),
                );
              }
              final List<BedModel> bedList = snapshot.data!;
              if (_unavailableBeds.isEmpty && _availableBeds.isEmpty) {
                _separateBeds(bedList);
              }
              totalBeds = bedList.length;
              return Stack(
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
                            _toggleValue
                                ? "${_availableBeds.length}"
                                : "${_unavailableBeds.length}",
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
                                    side: WidgetStateProperty.all<BorderSide>(
                                        const BorderSide(color: greyColor)),
                                    shape: WidgetStateProperty.all<
                                        OutlinedBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            _toggleValue
                                                ? greenColor
                                                : Colors.transparent),
                                  ),
                                  onPressed: () =>
                                      _onAvailabilityChangeButton(),
                                  child: Text(
                                    "Available",
                                    style: TextStyle(
                                      fontSize: SizeConfig.font16(context),
                                      color:
                                          _toggleValue ? whiteColor : greyColor,
                                    ),
                                  )),
                              TextButton(
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all<BorderSide>(
                                      const BorderSide(color: greyColor)),
                                  shape:
                                      WidgetStateProperty.all<OutlinedBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius
                                          .zero, // Set border radius to zero for square shape
                                    ),
                                  ),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          _toggleValue
                                              ? Colors.transparent
                                              : redColor),
                                ),
                                onPressed: () => _onAvailabilityChangeButton(),
                                child: Text(
                                  "UnAvailable",
                                  style: TextStyle(
                                      fontSize: SizeConfig.font16(context),
                                      color: _toggleValue
                                          ? greyColor
                                          : whiteColor),
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
                    child: _toggleValue
                        ? ListView.builder(
                            itemCount: _availableBeds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BedCard(
                                bedModel: _availableBeds[index],
                                secondaryIndex: index,
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _unavailableBeds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BedCard(
                                bedModel: _unavailableBeds[index],
                                secondaryIndex: index,
                              );
                            },
                          ),
                  ),
                ],
              );
            }),
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
    int totalBeds,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddingBed(
            totalBeds: totalBeds,
            hopspitalId: widget.hospitalId,
          );
        });
  }

  void _separateBeds(List<BedModel> bedList) {
    for (int i = 0; i < bedList.length; i++) {
      if (bedList[i].isAvailable) {
        _unavailableBeds.add(bedList[i]);
      } else {
        _availableBeds.add(bedList[i]);
      }
    }
  }
}
