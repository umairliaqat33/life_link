import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: SizeConfig.width20(context) * 7.5,
        height: SizeConfig.height20(context) * 7,
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                spreadRadius: 3,
                blurRadius: 2,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: SvgPicture.asset(
                icon,
                height: SizeConfig.height18(context) * 2,
                width: SizeConfig.width12(context) * 3,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.font14(context) + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
