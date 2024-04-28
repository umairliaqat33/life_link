import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_info_card_tile.dart';

class HistoryInfoCard extends StatelessWidget {
  const HistoryInfoCard({
    super.key,
    required this.education,
    required this.comingTime,
    required this.leavingTime,
    required this.speciality,
    required this.otherExperience,
  });

  final String education;
  final String comingTime;
  final String leavingTime;
  final String speciality;
  final String otherExperience;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        DoctorInfoCardTile(
          title: 'Education',
          valueText: education,
        ),
        DoctorInfoCardTile(
          title: 'Arriving time',
          valueText: comingTime,
        ),
        DoctorInfoCardTile(
          title: 'Leaving time',
          valueText: leavingTime,
        ),
        DoctorInfoCardTile(
          title: 'Speciality',
          valueText: speciality,
        ),
        DoctorInfoCardTile(
          title: 'Other Experience',
          valueText: otherExperience,
        ),
      ],
    ));
  }
}
