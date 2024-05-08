import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/widgets/switchs/custom_switch.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class BedCard extends StatefulWidget {
  const BedCard({
    super.key,
    required this.index,
    required this.isAvailable,
    required this.mainIndex,
    required this.mainList,
  });
  final int index;
  final bool isAvailable;
  final int mainIndex;
  final List<bool> mainList;

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
            "BD-00${widget.index + 1}",
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
    _toggle = widget.isAvailable;
    setState(() {});
  }

  void _updateBedList() {
    try {
      List<bool> list = [];
      for (int i = 0; i < widget.mainList.length; i++) {
        if (i == widget.mainIndex) {
          list.add(_toggle);
        } else {
          list.add(widget.mainList[i]);
        }
      }
      FirestoreController firestoreController = FirestoreController();
      firestoreController.changeBedAvailability(list);
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
