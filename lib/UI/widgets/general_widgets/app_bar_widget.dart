import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

PreferredSize appBarWidget({
  required String title,
  required BuildContext context,
  required bool backButton,
  Color backButtonColor = whiteColor,
  bool centerTitle = true,
  Color bgColor = appBarColor,
  Color textColor = whiteColor,
  String picture = Assets.backButtonWhiteImage,
  Function? backButtonFunction,
}) {
  return PreferredSize(
    preferredSize: Size(
      double.infinity,
      (SizeConfig.height12(context) * 4),
    ),
    child: AppBar(
      elevation: 1,
      backgroundColor: bgColor,
      centerTitle: centerTitle,
      leading: backButton
          ? MaterialButton(
              onPressed: backButtonFunction == null
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : backButtonFunction(),
              child: SvgPicture.asset(
                backButtonColor == whiteColor
                    ? picture
                    : Assets.backButtonBlackImage,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: SizeConfig.font18(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
