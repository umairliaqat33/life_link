import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_tile.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item1Title,
    required this.item2Title,
    required this.item3Title,
    required this.item4Title,
    required this.item5Title,
  });

  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;
  final String item1Title;
  final String item2Title;
  final String item3Title;
  final String item4Title;
  final String item5Title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InfoCardTile(
            title: item1Title,
            valueText: item1,
          ),
          InfoCardTile(
            title: item2Title,
            valueText: item2,
          ),
          InfoCardTile(
            title: item3Title,
            valueText: item3,
          ),
          InfoCardTile(
            title: item4Title,
            valueText: item4,
          ),
          InfoCardTile(
            title: item5Title,
            valueText: item5,
          ),
        ],
      ),
    );
  }
}
