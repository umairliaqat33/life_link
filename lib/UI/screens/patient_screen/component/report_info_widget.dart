import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_info_card_tile.dart';

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
        DoctorInfoCardTile(
          title: "Hospital Name",
          valueText: hospital,
        ),
        DoctorInfoCardTile(
          title: 'Arriving Date',
          valueText: admitDate,
        ),
        DoctorInfoCardTile(
          title: 'Bed No',
          valueText: bedno,
        ),
        DoctorInfoCardTile(
          title: 'Checked By',
          valueText: checkby,
        ),
        DoctorInfoCardTile(
          title: 'Disease',
          valueText: disease,
        ),
        DoctorInfoCardTile(
          title: 'Discharge Date',
          valueText: dischargeDate,
        ),
        DoctorInfoCardTile(
          title: "Ambulance Driver",
          valueText: driver,
        )
      ],
    ));
  }
}
