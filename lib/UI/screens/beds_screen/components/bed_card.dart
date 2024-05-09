import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/widgets/switchs/custom_switch.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class BedCard extends StatefulWidget {
  const BedCard({
    super.key,
    required this.bedModel,
    required this.secondaryIndex,
  });
  final BedModel bedModel;
  final int secondaryIndex;

  @override
  State<BedCard> createState() => _BedCardState();
}

class _BedCardState extends State<BedCard> {
  bool _toggle = false;
  @override
  void initState() {
    super.initState();
    _setValue();
  }

  @override
  void didUpdateWidget(covariant BedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setValue();
  }

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
            "BD-00${widget.bedModel.bedId + 1}",
            style: TextStyle(fontSize: SizeConfig.font18(context)),
          ),
          leading: const Icon(Icons.bed_rounded),
          subtitle: Text(_toggle ? "Assigned" : "Not Assigned"),
          trailing: CustomSwitch(
            value: _toggle,
            onChanged: (value) {
              _toggle = value;
              _updateBedList();
              setState(() {});
            },
            activeColor: greenColor,
            inactiveColor: redColor,
          ),
        ),
      ),
    );
  }

  void _setValue() {
    _toggle = widget.bedModel.isAvailable;
    setState(() {});
  }

  void _updateBedList() {
    try {
      FirestoreController firestoreController = FirestoreController();
      firestoreController.changeBedAvailability(
        BedModel(
          isAvailable: _toggle,
          bedId: widget.bedModel.bedId,
          hospitalId: widget.bedModel.hospitalId,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
        (route) => false,
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
