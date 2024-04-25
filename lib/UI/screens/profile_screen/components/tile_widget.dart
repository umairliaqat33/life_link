import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_link/config/size_config.dart';

import 'package:life_link/utils/colors.dart';

class TileWidget extends StatelessWidget {
  final String text;
  final String? trailingImg;
  final String? leadingImg;
  final VoidCallback? onTap;
  final Color cardColor;
  final Color titleTextColor;

  const TileWidget({
    super.key,
    required this.text,
    required this.trailingImg,
    required this.leadingImg,
    required this.onTap,
    required this.cardColor,
    this.titleTextColor = greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(
            color: titleTextColor,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.font14(context),
          ),
        ),
        trailing: trailingImg == null
            ? null
            : SvgPicture.asset(
                trailingImg!,
              ),
        leading: leadingImg == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SvgPicture.asset(
                  leadingImg!,
                ),
              ),
        horizontalTitleGap: 0,
      ),
    );
  }
}
