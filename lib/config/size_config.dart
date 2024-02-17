import 'package:flutter/material.dart';

class SizeConfig {
  static height(BuildContext context) => MediaQuery.of(context).size.height;
  static width(BuildContext context) => MediaQuery.of(context).size.width;

  static height5(BuildContext context) => height(context) / 160.8;
  static height8(BuildContext context) => height(context) / 100.5;
  static height10(BuildContext context) => height(context) / 80.4;
  static height12(BuildContext context) => height(context) / 67;
  static height15(BuildContext context) => height(context) / 53.6;
  static height18(BuildContext context) => height(context) / 44.66;
  static height20(BuildContext context) => height(context) / 40.2;

  static width5(BuildContext context) => width(context) / 72;
  static width8(BuildContext context) => width(context) / 45;
  static width10(BuildContext context) => width(context) / 36;
  static width12(BuildContext context) => width(context) / 30;
  static width15(BuildContext context) => width(context) / 24;
  static width20(BuildContext context) => width(context) / 18;

  static font10(BuildContext context) => height(context) / 80.4;
  static font12(BuildContext context) => height(context) / 67;
  static font14(BuildContext context) => height(context) / 57.42;
  static font16(BuildContext context) => height(context) / 50.25;
  static font18(BuildContext context) => height(context) / 44.66;
  static font20(BuildContext context) => height(context) / 40.2;
  static font22(BuildContext context) => height(context) / 36.54;
  static font24(BuildContext context) => height(context) / 33.5;
  static font28(BuildContext context) => height(context) / 28.71;

  static pad8(BuildContext context) => height(context) / 100.5;
  static pad12(BuildContext context) => height(context) / 67;
  static pad14(BuildContext context) => height(context) / 57.42;
  static pad16(BuildContext context) => height(context) / 50.25;
  static pad20(BuildContext context) => height(context) / 40.2;
  static pad24(BuildContext context) => height(context) / 33.5;
}
