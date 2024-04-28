import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_info_card_tile.dart';

class HistoryInfo extends StatelessWidget {
  const HistoryInfo({
    super.key,
    required this.bedno,
    required this.comingDate,
    required this.dischargeDate,
    required this.checkby,
    required this.disease,
  });

  final String bedno;
  final String comingDate;
  final String dischargeDate;
  final String checkby;
  final String disease;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        DoctorInfoCardTile(
          title: 'Bed No',
          valueText: bedno,
        ),
        DoctorInfoCardTile(
          title: 'Arriving Date',
          valueText: comingDate,
        ),
        DoctorInfoCardTile(
          title: 'Discharge Date',
          valueText: dischargeDate,
        ),
        DoctorInfoCardTile(
          title: 'Checked By',
          valueText: checkby,
        ),
        DoctorInfoCardTile(
          title: 'Disease',
          valueText: disease,
        ),
      ],
    ));
  }
}
