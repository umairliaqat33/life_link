import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_tile.dart';

class ReportInfo extends StatelessWidget {
  const ReportInfo(
      {super.key,
      required this.bedno,
      required this.admitDate,
      required this.dischargeDate,
      required this.checkby,
      required this.disease,
      required this.driver,
      required this.hospital});

  final String bedno;
  final String admitDate;
  final String dischargeDate;
  final String checkby;
  final String disease;
  final String hospital;
  final String driver;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        InfoCardTile(
          title: "Hospital Name",
          valueText: hospital,
        ),
        InfoCardTile(
          title: 'Arriving Date',
          valueText: admitDate,
        ),
        InfoCardTile(
          title: 'Bed No',
          valueText: bedno,
        ),
        InfoCardTile(
          title: 'Checked By',
          valueText: checkby,
        ),
        InfoCardTile(
          title: 'Disease',
          valueText: disease,
        ),
        InfoCardTile(
          title: 'Discharge Date',
          valueText: dischargeDate,
        ),
        InfoCardTile(
          title: "Ambulance Driver",
          valueText: driver,
        )
      ],
    ));
  }
}
